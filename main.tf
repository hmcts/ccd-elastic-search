module "elastic" {
  source = "git@github.com:hmcts/cnp-module-elk.git?ref=master"
  product = "${var.product}"
  location = "${var.location}"
  env = "${var.env}"
  common_tags = "${var.common_tags}"
  vNetName = "data.terraform_remote_state.core_apps_infrastructure.vnetname"
  vNetExistingResourceGroup = "data.terraform_remote_state.core_apps_infrastructure.resourcegroup_name"
  vNetClusterSubnetName = "data.terraform_remote_state.core_apps_infrastructure.subnet_names[2]"
  vNetLoadBalancerIp = "unused"
}

module "logstash" {
  count = "${var.deploy_logstash == "true" ? 1 : 0}"
  source = "git@github.com:hmcts/cnp-module-logstash.git?ref=master"
  product = "${var.product}"
  location = "${var.location}"
  env = "${var.env}"
  common_tags = "${var.common_tags}"
  target_elastic_search_resource_group = "${module.elastic.elastic_resource_group_name}}"
}