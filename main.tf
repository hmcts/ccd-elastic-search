locals {
  // Vault name
  previewVaultName    = "${var.raw_product}-aat"
  nonPreviewVaultName = "${var.raw_product}-${var.env}"
  vaultName           = (var.env == "preview" || var.env == "spreview") ? local.previewVaultName : local.nonPreviewVaultName
  dummy_local         = ""

  // Shared Resource Group
  previewResourceGroup    = "${var.raw_product}-shared-aat"
  nonPreviewResourceGroup = "${var.raw_product}-shared-${var.env}"
  sharedResourceGroup     = (var.env == "preview" || var.env == "spreview") ? local.previewResourceGroup : local.nonPreviewResourceGroup

  // generate an url consisting of the data nodes e.g. "http://ccd-data-1:9200","http://ccd-data-2:9200"
  es_data_nodes_url = join(",", data.template_file.es_data_nodes_url_template.*.rendered)

}

data "azurerm_virtual_network" "core_infra_vnet" {
  name                = "core-infra-vnet-${var.env}"
  resource_group_name = "core-infra-${var.env}"
}

data "azurerm_subnet" "elastic-subnet" {
  name                 = "elasticsearch"
  virtual_network_name = data.azurerm_virtual_network.core_infra_vnet.name
  resource_group_name  = data.azurerm_virtual_network.core_infra_vnet.resource_group_name
}

data "azurerm_key_vault" "key_vault" {
  name                = local.vaultName
  resource_group_name = local.sharedResourceGroup
}

data "azurerm_key_vault_secret" "ccd_elastic_search_public_key" {
  name         = "${var.raw_product}-ELASTIC-SEARCH-PUB-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "dynatrace_token" {
  name         = "dynatrace-token"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "elastic_search_url_key_setting" {
  name         = "${var.raw_product}-ELASTIC-SEARCH-URL"
  value        = var.lb_private_ip_address
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "alerts_email" {
  name         = "elk-alerts-email"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

// generate an url consisting of the data nodes e.g. "http://ccd-data-1:9200.service.core-compute-${var.env}.internal","http://ccd-data-2.service.core-compute-${var.env}.internal:9200"
data "template_file" "es_data_nodes_url_template" {
  template = "\"http://ccd-data-$${index}.service.core-compute-$${env}.internal:9200\""
  count    = var.vmDataNodeCount

  vars = {
    index = "${count.index}"
    env   = "${var.env}"
  }
}

resource "azurerm_key_vault_secret" "es_data_nodes_url" {
  name         = "${var.raw_product}-ELASTIC-SEARCH-DATA-NODES-URL"
  value        = local.es_data_nodes_url
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

# AMA Data Collection Rule Association
data "azurerm_resource_group" "la_rg" {
  provider = azurerm.dcr
  name     = "oms-automation"
}

data "azurerm_monitor_data_collection_rule" "linux_data_collection_rule" {
  provider            = azurerm.dcr
  name                = "ama-linux-vm-logs"
  resource_group_name = data.azurerm_resource_group.la_rg.name
}

resource "azurerm_monitor_data_collection_rule_association" "linux_vm_dcra" {
  for_each = length(var.elastic_search_clusters) > 0 ? {} : var.vms

  name                    = "vm-${each.value.name}-${var.env}-dcra"
  target_resource_id      = module.elastic2[each.key].vm_id
  data_collection_rule_id = data.azurerm_monitor_data_collection_rule.linux_data_collection_rule.id
  description             = "Association between the ELK linux VMs and the appropriate data collection rule."
}

resource "azurerm_monitor_data_collection_rule_association" "linux_vm_dcra_cluster" {
  for_each = local.use_new_structure ? local.flattened_vms : {}

  name                    = "vm-${each.value.name}-${var.env}-dcra"
  target_resource_id      = module.elastic2_cluster[each.key].vm_id
  data_collection_rule_id = data.azurerm_monitor_data_collection_rule.linux_data_collection_rule.id
  description             = "Association between the ELK linux VMs and the appropriate data collection rule."
}

module "storageaccount" {
  source = "git@github.com:hmcts/cnp-module-storage-account?ref=4.x"
  count  = var.env == "perftest" ? 1 : 0

  env                  = var.env
  storage_account_name = var.storage_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  account_kind         = var.account_kind
  containers = [{
    name        = "es-snapshots"
    access_type = "private"
  }]
  common_tags = var.common_tags
}
