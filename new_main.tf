
provider "azurerm" {
  alias = "cnp"
  features {}
  subscription_id = var.env == "nonprod" || var.env == "sandbox" ? "1c4f0704-a29e-403d-b719-b90c34ef14c9" : "8999dec3-0104-4a27-94ee-6588559729d1"
}

provider "azurerm" {
  alias = "soc"
  features {}
  subscription_id = "8ae5b3b6-0b12-4888-b894-4cec33c92292"
}

provider "azurerm" {
  alias = "dcr"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8999dec3-0104-4a27-94ee-6588559729d1" : var.env == "sbox" || var.env == "sandbox" ? "bf308a5c-0624-4334-8ff8-8dca9fd43783" : "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}


module "elastic2" {
  for_each = var.env == "sandbox" ? toset(var.vms) : {}

  providers = {
    azurerm     = azurerm
    azurerm.cnp = azurerm.cnp
    azurerm.soc = azurerm.soc
    azurerm.dcr = azurerm.dcr
  }
  source            = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"
  env               = var.env
  vm_name           = each.value.name
  vm_resource_group = "ccd-elastic-search-${var.env}"
  vm_admin_password = random_password.vm_password.result
  vm_subnet_id      = data.azurerm_subnet.elastic-subnet.id
  vm_private_ip     = each.value.ip
  os_disk_name      = "${each.value.name}-osdisk"
  tags              = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
  managed_disks     = each.value.managed_disks
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
