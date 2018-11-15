module "elastic" {
  source = "git@github.com:hmcts/cnp-module-elk.git?ref=master"
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
  ssh_elastic_search_public_key = "${data.azurerm_key_vault_secret.ccd_elastic_search_public_key.value}"
}

locals {
  // Vault name
  previewVaultName = "${var.product}-aat"
  nonPreviewVaultName = "${var.product}-${var.env}"
  vaultName = "${(var.env == "preview" || var.env == "spreview") ? local.previewVaultName : local.nonPreviewVaultName}"

  // Shared Resource Group
  previewResourceGroup = "${var.product}-shared-aat"
  nonPreviewResourceGroup = "${var.product}-shared-${var.env}"
  sharedResourceGroup = "${(var.env == "preview" || var.env == "spreview") ? local.previewResourceGroup : local.nonPreviewResourceGroup}"
}

data "azurerm_key_vault" "ccd_shared_key_vault" {
  name = "${local.vaultName}"
  resource_group_name = "${local.sharedResourceGroup}"
}

data "azurerm_key_vault_secret" "ccd_elastic_search_public_key" {
  name = "ccd-ELASTIC-SEARCH-PUB-KEY"
  vault_uri = "${data.azurerm_key_vault.ccd_shared_key_vault.vault_uri}"
}

resource "azurerm_key_vault_secret" "elastic_search_url_key_setting" {
  name = "${var.product}-ELASTIC-SEARCH-URL"
  value = "${module.elastic.loadbalancerManual}"
  vault_uri = "${data.azurerm_key_vault.ccd_shared_key_vault.vault_uri}"
}

resource "azurerm_key_vault_secret" "elastic_search_pwd_key_setting" {
  name = "${var.product}-ELASTIC-SEARCH-PASSWORD"
  value = "${module.elastic.elasticsearch_admin_password}"
  vault_uri = "${data.azurerm_key_vault.ccd_shared_key_vault.vault_uri}"
}
