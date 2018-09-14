module "elastic" {
  source = "git@github.com:hmcts/cnp-module-elk.git?ref=master"
  product = "${var.product}"
  location = "${var.location}"
  env = "${var.env}"
  common_tags = "${var.common_tags}"
}