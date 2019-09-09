provider "azurerm" {
  version = "1.22.1"
}

module "elastic" {
  source = "git@github.com:hmcts/cnp-module-elk.git?ref=curator"
  product = "${var.product}"
  location = "${var.location}"
  env = "${var.env}"
  subscription = "${var.subscription}"
  common_tags = "${var.common_tags}"
  dataNodesAreMasterEligible = "${var.dataNodesAreMasterEligible}"
  vmDataNodeCount = "${var.vmDataNodeCount}"
  vmSizeAllNodes = "${var.vmSizeAllNodes}"
  storageAccountType = "${var.storageAccountType}"
  vmDataDiskCount = "${var.vmDataDiskCount}"
  kibanaAdditionalYaml = "${var.kibanaAdditionalYaml}"
  esAdditionalYaml = "${var.esAdditionalYaml}"
  ssh_elastic_search_public_key = "${data.azurerm_key_vault_secret.ccd_elastic_search_public_key.value}"
  mgmt_subscription_id = "${var.mgmt_subscription_id}"
  logAnalyticsId = "${data.azurerm_log_analytics_workspace.log_analytics.workspace_id}"
  logAnalyticsKey = "${data.azurerm_log_analytics_workspace.log_analytics.primary_shared_key}"
}

locals {
  // Vault name
  previewVaultName = "${var.raw_product}-aat"
  nonPreviewVaultName = "${var.raw_product}-${var.env}"
  vaultName = "${(var.env == "preview" || var.env == "spreview") ? local.previewVaultName : local.nonPreviewVaultName}"

  // Shared Resource Group
  previewResourceGroup = "${var.raw_product}-shared-aat"
  nonPreviewResourceGroup = "${var.raw_product}-shared-${var.env}"
  sharedResourceGroup = "${(var.env == "preview" || var.env == "spreview") ? local.previewResourceGroup : local.nonPreviewResourceGroup}"

  // generate an url consisting of the data nodes e.g. "http://ccd-data-1:9200","http://ccd-data-2:9200"
  es_data_nodes_url = "${join(",", data.template_file.es_data_nodes_url_template.*.rendered)}"
}

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "hmcts-${var.subscription}"
  resource_group_name = "oms-automation"
}

data "azurerm_key_vault" "ccd_shared_key_vault" {
  name = "${local.vaultName}"
  resource_group_name = "${local.sharedResourceGroup}"
}

data "azurerm_key_vault_secret" "ccd_elastic_search_public_key" {
  name = "${var.product}-ELASTIC-SEARCH-PUB-KEY"
  key_vault_id = "${data.azurerm_key_vault.ccd_shared_key_vault.id}"
}

resource "azurerm_key_vault_secret" "elastic_search_url_key_setting" {
  name = "${var.product}-ELASTIC-SEARCH-URL"
  value = "${module.elastic.loadbalancerManual}"
  key_vault_id = "${data.azurerm_key_vault.ccd_shared_key_vault.id}"
}

resource "azurerm_key_vault_secret" "elastic_search_pwd_key_setting" {
  name = "${var.product}-ELASTIC-SEARCH-PASSWORD"
  value = "${module.elastic.elasticsearch_admin_password}"
  key_vault_id = "${data.azurerm_key_vault.ccd_shared_key_vault.id}"
}

resource "azurerm_key_vault_secret" "elastic_search_data_nodes_count" {
  name = "${var.product}-ELASTIC-SEARCH-DATA-NODES-COUNT"
  value = "${var.vmDataNodeCount}"
  key_vault_id = "${data.azurerm_key_vault.ccd_shared_key_vault.id}"
}

// generate an url consisting of the data nodes e.g. "http://ccd-data-1:9200.service.core-compute-${var.env}.internal","http://ccd-data-2.service.core-compute-${var.env}.internal:9200"
data "template_file" "es_data_nodes_url_template" {
  template = "\"http://ccd-data-$${index}.service.core-compute-$${env}.internal:9200\""
  count    = "${var.vmDataNodeCount}"

  vars = {
    index   = "${count.index}"
    env = "${var.env}"
  }
}

resource "azurerm_key_vault_secret" "es_data_nodes_url" {
  name = "${var.product}-ELASTIC-SEARCH-DATA-NODES-URL"
  value = "${local.es_data_nodes_url}"
  key_vault_id = "${data.azurerm_key_vault.ccd_shared_key_vault.id}"
}
