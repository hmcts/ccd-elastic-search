locals {
  linux        = "linux"
  expiresAfter = "3000-01-01"

  # Flatten elastic_search_clusters into individual VM configurations
  flattened_vms = merge([
    for cluster_key, cluster in var.elastic_search_clusters : {
      for instance_idx in range(cluster.instance_count) :
      format(cluster.name_template, instance_idx) => {
        cluster_key  = cluster_key
        instance_idx = instance_idx
        name         = format(cluster.name_template, instance_idx)
        ip           = try(cluster.private_ip_allocation[instance_idx], null)
        resource_group_name = coalesce(
          cluster.resource_group_name,
          cluster_key == "upgrade" ? "ccd-elastic-search-upgrade-${var.env}" : "ccd-elastic-search-${var.env}"
        )
        managed_disks = {
          for disk_idx in range(cluster.data_disks) :
          "disk${disk_idx + 1}" => {
            name = "${format(cluster.name_template, instance_idx)}-datadisk${disk_idx + 1}"
            resource_group_name = coalesce(
              cluster.resource_group_name,
              cluster_key == "upgrade" ? "ccd-elastic-search-upgrade-${var.env}" : "ccd-elastic-search-${var.env}"
            )
            location                 = var.location
            storage_account_type     = coalesce(cluster.storage_account_type, "StandardSSD_LRS")
            disk_size_gb             = "1024"
            disk_lun                 = tostring(disk_idx)
            disk_caching             = "None"
            disk_create_option       = "Empty"
            attachment_create_option = lookup(cluster, "attachment_create_option", "Empty")
          }
        }
        vm_publisher_name     = cluster.vm_publisher_name
        vm_offer              = cluster.vm_offer
        vm_sku                = cluster.vm_sku
        vm_version            = cluster.vm_version
        vm_size               = cluster.vm_size
        availability_set_name = cluster.availability_set_name
        lb_private_ip_address = cluster.lb_private_ip_address
      }
    }
  ]...)

  # Combine legacy vms with flattened cluster VMs
  all_vms = merge(var.vms, local.flattened_vms)

  # Group VMs by cluster for load balancer configuration
  vms_by_cluster = {
    for cluster_key, cluster in var.elastic_search_clusters :
    cluster_key => {
      for vm_key, vm in local.flattened_vms :
      vm_key => vm
      if vm.cluster_key == cluster_key
    }
  }

  # Extract load balancer configurations from clusters
  cluster_load_balancers = {
    for cluster_key, cluster in var.elastic_search_clusters :
    cluster_key => {
      # Keep legacy name format when cluster_key is "default" for backward compatibility
      name = cluster_key == "default" ? "ccd-internal-${var.env}-lb" : "ccd-internal-${var.env}-${cluster_key}-lb"
      resource_group_name = coalesce(
        cluster.resource_group_name,
        cluster_key == "upgrade" ? "ccd-elastic-search-upgrade-${var.env}" : "ccd-elastic-search-${var.env}"
      )
      lb_private_ip_address = cluster.lb_private_ip_address
      vms                   = local.vms_by_cluster[cluster_key]
    }
    if cluster.lb_private_ip_address != null
  }

  # Determine which structure to use
  use_new_structure = length(var.elastic_search_clusters) > 0
}

# ORIGINAL module for environments using vms variable (e.g., AAT, prod, demo, perftest)
# Keep this as-is to avoid state file moves
module "elastic2" {
  for_each = var.vms

  providers = {
    azurerm     = azurerm
    azurerm.cnp = azurerm.cnp
    azurerm.soc = azurerm.soc
    azurerm.dcr = azurerm.dcr
  }
  source                       = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"
  env                          = var.env
  vm_name                      = each.value.name
  vm_resource_group            = try(each.value.resource_group_name, azurerm_resource_group.this.name)
  vm_admin_password            = null
  vm_admin_name                = var.vm_admin_name
  vm_subnet_id                 = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip                = each.value.ip
  os_disk_name                 = "${each.value.name}-osdisk"
  tags                         = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks                = each.value.managed_disks
  soc_vault_name               = var.soc_vault_name
  soc_vault_rg                 = var.soc_vault_rg
  vm_admin_ssh_key             = data.azurerm_key_vault_secret.ssh_public_key.value
  vm_publisher_name            = var.vm_publisher_name
  vm_offer                     = var.vm_offer
  vm_sku                       = var.vm_sku
  vm_version                   = var.vm_version
  vm_size                      = var.vm_size
  enable_availability_set      = var.enable_availability_set
  availability_set_name        = var.availability_set_name
  platform_update_domain_count = var.platform_update_domain_count
  ipconfig_name                = var.ipconfig_name
}

# NEW module for environments using elastic_search_clusters (e.g., ITHC)
module "elastic2_cluster" {
  for_each = local.use_new_structure ? local.flattened_vms : {}

  providers = {
    azurerm     = azurerm
    azurerm.cnp = azurerm.cnp
    azurerm.soc = azurerm.soc
    azurerm.dcr = azurerm.dcr
  }
  source                       = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"
  env                          = var.env
  vm_name                      = each.value.name
  vm_resource_group            = try(each.value.resource_group_name, azurerm_resource_group.this.name)
  vm_admin_password            = null
  vm_admin_name                = var.vm_admin_name
  vm_subnet_id                 = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip                = each.value.ip
  os_disk_name                 = "${each.value.name}-osdisk"
  tags                         = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks                = each.value.managed_disks
  soc_vault_name               = var.soc_vault_name
  soc_vault_rg                 = var.soc_vault_rg
  vm_admin_ssh_key             = data.azurerm_key_vault_secret.ssh_public_key.value
  vm_publisher_name            = coalesce(try(each.value.vm_publisher_name, null), var.vm_publisher_name)
  vm_offer                     = coalesce(try(each.value.vm_offer, null), var.vm_offer)
  vm_sku                       = coalesce(try(each.value.vm_sku, null), var.vm_sku)
  vm_version                   = coalesce(try(each.value.vm_version, null), var.vm_version)
  vm_size                      = coalesce(try(each.value.vm_size, null), var.vm_size)
  enable_availability_set      = var.enable_availability_set
  availability_set_name        = coalesce(try(each.value.availability_set_name, null), var.availability_set_name)
  platform_update_domain_count = var.platform_update_domain_count
  ipconfig_name                = var.ipconfig_name
  privateip_allocation         = each.value.cluster_key == "upgrade" ? "Static" : "Dynamic"
}

module "elastic2_demo_int" {
  for_each = var.enable_demo_int ? var.vms_demo_int : {}

  providers = {
    azurerm     = azurerm
    azurerm.cnp = azurerm.cnp
    azurerm.soc = azurerm.soc
    azurerm.dcr = azurerm.dcr
  }
  source                       = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"
  env                          = var.env
  vm_name                      = each.value.name
  vm_resource_group            = var.demo_int_rg_name
  vm_admin_password            = null
  vm_admin_name                = var.vm_admin_name
  vm_subnet_id                 = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip                = each.value.ip
  os_disk_name                 = "${each.value.name}-osdisk"
  tags                         = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks                = each.value.managed_disks
  soc_vault_name               = var.soc_vault_name
  soc_vault_rg                 = var.soc_vault_rg
  vm_admin_ssh_key             = data.azurerm_key_vault_secret.ssh_public_key.value
  vm_publisher_name            = var.vm_publisher_name_int
  vm_offer                     = var.vm_offer_int
  vm_sku                       = var.vm_sku_int
  vm_version                   = var.vm_version_int
  vm_size                      = var.vm_size
  enable_availability_set      = var.enable_availability_set
  availability_set_name        = var.availability_set_name_demo_int
  platform_update_domain_count = var.platform_update_domain_count
  ipconfig_name                = var.ipconfig_name
  privateip_allocation         = var.vm_privateip_allocation
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags.git?ref=master"

  builtFrom    = "https://github.com/HMCTS/ccd-elastic-search.git"
  environment  = var.env
  product      = "ccd"
  autoShutdown = var.env == "prod" || var.env == "production" ? false : true
}


resource "azurerm_resource_group" "this" {
  name     = "ccd-elastic-search-${var.env}"
  location = var.location
  tags     = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_resource_group" "upgrade" {
  count    = length(var.elastic_search_clusters) > 0 && contains(keys(var.elastic_search_clusters), "upgrade") ? 1 : 0
  name     = "ccd-elastic-search-upgrade-${var.env}"
  location = var.location
  tags     = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_resource_group" "demo_int" {
  count    = var.enable_demo_int ? 1 : 0
  name     = var.demo_int_rg_name
  location = var.location
  tags     = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_key_vault_secret" "admin_name" {
  name         = "ccd-vm-admin-name"
  value        = var.vm_admin_name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}



# Only need this blocks when redeploying the resources from scratch

# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }


# Write to key vault
# resource "azurerm_key_vault_secret" "ssh_public_key" {
#   name         = "ccd-ELASTIC-SEARCH-PUB-KEY"
#   value        = tls_private_key.rsa.public_key_openssh
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }

# resource "azurerm_key_vault_secret" "ssh_private_key" {
#   name         = "ccd-vm-ssh-private-key"
#   value        = tls_private_key.rsa.private_key_pem
#   key_vault_id = data.azurerm_key_vault.key_vault.id
# }

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ccd-ELASTIC-SEARCH-PUB-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault.id

}

data "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ccd-ELASTIC-SEARCH-PRIVATE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
