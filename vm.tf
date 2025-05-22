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
  vm_admin_password = null
  vm_subnet_id      = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip     = each.value.ip
  os_disk_name      = "${each.value.name}-osdisk"
  tags              = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks     = each.value.managed_disks
  soc_vault_name    = var.soc_vault_name
  soc_vault_rg      = var.soc_vault_rg
  vm_admin_ssh_key  = data.azurerm_key_vault_secret.ssh_public_key.value
}

locals {
  linux        = "linux"
  expiresAfter = "3000-01-01"
}

module "ctags" {
  source = "github.com/hmcts/terraform-module-common-tags.git?ref=master"

  builtFrom   = "github.com/hmcts/ccd-module-elastic-search"
  environment = var.env
  product     = "ccd"
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

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ccd-ELASTIC-SEARCH-PUB-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ccd-ELASTIC-SEARCH-PRIVATE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

