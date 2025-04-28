provider "azurerm" {
  alias = "cnp"
  features {}
  subscription_id = var.env == "nonprod" || var.env == "sandbox" ? "1c4f0704-a29e-403d-b719-b90c34ef14c9" : "8999dec3-0104-4a27-94ee-6588559729d1"
}

provider "azurerm" {
  alias = "soc"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8ae5b3b6-0b12-4888-b894-4cec33c92292" : var.env == "sbox" || var.env == "sandbox" ? "2307d175-7e49-434b-9ac2-515529b845f2" : "8ae5b3b6-0b12-4888-b894-4cec33c92292"
}

provider "azurerm" {
  alias = "dcr"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8999dec3-0104-4a27-94ee-6588559729d1" : var.env == "sbox" || var.env == "sandbox" ? "bf308a5c-0624-4334-8ff8-8dca9fd43783" : "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}


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

resource "terraform_data" "vm" {
  for_each = var.env == "sandbox" ? var.vms : {}
  triggers_replace = [
    timestamp()
  ]
  connection {
    type     = "ssh"
    host     = each.value.ip
    user     = azurerm_key_vault_secret.admin_name.value
    password = local.lin_password
    timeout  = "15m"
  }
  provisioner "remote-exec" {
    inline = [
      "echo Hello from $(hostname)",
      "sudo apt update && sudo apt install -y ansible",
      "ansible-pull -U https://github.com/hmcts/ccd-elastic-search.git -C DTSPO-24632-module-consume -i ansible/inventory.ini ansible/main.yml --extra-vars 'ansible_hostname=${each.value.name} elastic_clustername=ccd-elastic-search-${var.env}'",
    ]
  }

}


data "azurerm_key_vault_secret" "privatekey" {
  name         = "ccd-vm-ssh-private-key-new"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
