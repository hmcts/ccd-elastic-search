terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias                      = "aks-infra"
  subscription_id            = var.aks_subscription_id
  skip_provider_registration = true
  features {}
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = var.mgmt_subscription_id
  features {}
}

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

  vNetLoadBalancerIp = cidrhost(data.azurerm_subnet.elastic-subnet.address_prefix, -2)
}

module "elastic" {
  source                        = "git@github.com:hmcts/cnp-module-elk.git?ref=DTSPO-17635/datadisk-sku"
  vmHostNamePrefix              = "ccd-"
  product                       = var.raw_product
  location                      = var.location
  env                           = var.env
  subscription                  = var.subscription
  esVersion                     = var.esVersion
  common_tags                   = var.common_tags
  vNetLoadBalancerIp            = local.vNetLoadBalancerIp
  dataNodesAreMasterEligible    = true
  vmDataNodeCount               = var.vmDataNodeCount
  vmSizeAllNodes                = var.vmSizeAllNodes
  storageAccountType            = var.storageAccountType
  dataStorageAccountType        = var.dataStorageAccountType
  vmDataDiskCount               = var.vmDataDiskCount
  ssh_elastic_search_public_key = data.azurerm_key_vault_secret.ccd_elastic_search_public_key.value
  providers = {
    azurerm           = azurerm
    azurerm.mgmt      = azurerm.mgmt
    azurerm.aks-infra = azurerm.aks-infra
  }
  logAnalyticsId       = data.azurerm_log_analytics_workspace.log_analytics.workspace_id
  logAnalyticsKey      = data.azurerm_log_analytics_workspace.log_analytics.primary_shared_key
  dynatrace_instance   = var.dynatrace_instance
  dynatrace_hostgroup  = var.dynatrace_hostgroup
  dynatrace_token      = data.azurerm_key_vault_secret.dynatrace_token.value
  enable_logstash      = false
  enable_kibana        = true
  alerts_email         = data.azurerm_key_vault_secret.alerts_email.value
  esAdditionalYaml     = var.esAdditionalYaml
  kibanaAdditionalYaml = var.kibanaAdditionalYaml
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

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "hmcts-${var.subscription}"
  resource_group_name = "oms-automation"
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
  value        = local.vNetLoadBalancerIp
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

resource "azurerm_key_vault_secret" "elastic_search_pwd_key_setting" {
  name         = "${var.raw_product}-ELASTIC-SEARCH-PASSWORD"
  value        = module.elastic.elasticsearch_admin_password
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
