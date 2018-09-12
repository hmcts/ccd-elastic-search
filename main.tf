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