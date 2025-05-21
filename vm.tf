module "elastic2" {
  for_each = var.env == "sandbox" ? var.vms : {}

  providers = {
    azurerm     = azurerm
    azurerm.cnp = azurerm.cnp
    azurerm.soc = azurerm.soc
    azurerm.dcr = azurerm.dcr
  }
  source            = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"
  env               = var.env
  vm_name           = each.value.name
  vm_resource_group = azurerm_resource_group.this.name
  vm_admin_password = local.lin_password
  vm_subnet_id      = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip     = each.value.ip
  os_disk_name      = "${each.value.name}-osdisk"
  tags              = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks     = each.value.managed_disks
  soc_vault_name    = var.soc_vault_name
  soc_vault_rg      = var.soc_vault_rg
  vm_admin_ssh_key  = tls_private_key.rsa.public_key_openssh
}



locals {
  lin_password  = random_password.vm_password.result
  linux         = "linux"
  expiresAfter  = "3000-01-01"
  nessus_server = "nessus-scanners-nonprod000005.platform.hmcts.net"
  nessus_groups = "Nonprod-test"
  nessus_key    = "nessus-agent-key-nonprod"
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags.git?ref=master"

  builtFrom   = "github.com/hmcts/ccd-module-elastic-search"
  environment = var.env
  product     = "ccd"
}
resource "random_password" "vm_password" {
  length           = 16
  special          = true
  override_special = "#$%&@()_[]{}<>:?"
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1

}

resource "azurerm_resource_group" "this" {
  name     = "ccd-elastic-search-${var.env}"
  location = var.location
  tags     = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_key_vault_secret" "admin_name" {
  name         = "ccd-vm-admin-name"
  value        = "ccdadmin"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "password" {
  name         = "ccd-vm-admin-password"
  value        = local.lin_password
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


# Write to key vault
resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ccd-vm-ssh-public-key"
  value        = tls_private_key.rsa.public_key_openssh
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ccd-vm-ssh-private-key"
  value        = tls_private_key.rsa.private_key_pem
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
