locals {
  lb_ports = {
    "http" = {
      name       = "es-http-internal"
      port       = 9200
      probe_name = "es-probe-http-internal"
    }
    "transport" = {
      name       = "es-transport-internal"
      port       = 9300
      probe_name = "es-probe-transport-internal"
    }
  }
}

# Main environment load balancer
module "main_lb" {
  source = "./modules/load-balancer"

  name                = "ccd-internal-${var.env}-lb"
  location            = var.location
  resource_group_name = "ccd-elastic-search-${var.env}"
  subnet_id           = data.azurerm_subnet.elastic-subnet.id
  ip_address          = var.lb_private_ip_address
  frontend_name       = "LBFE"
  backend_name        = "LBBE"
  vms                 = var.vms
  virtual_network_id  = data.azurerm_virtual_network.core_infra_vnet.id
  ports               = local.lb_ports
  tags                = module.ctags.common_tags
  expires_after       = var.env == "sandbox" ? local.expiresAfter : null
}

# Demo-int environment load balancer
module "demo_int_lb" {
  count  = var.enable_demo_int ? 1 : 0
  source = "./modules/load-balancer"

  name                = "ccd-internal-demo-int-lb"
  location            = var.location
  resource_group_name = var.demo_int_rg_name
  subnet_id           = data.azurerm_subnet.elastic-subnet.id
  ip_address          = var.lb_private_ip_address_demo_int
  frontend_name       = "LBFE-DEMO-INT"
  backend_name        = "LBBE-DEMO-INT"
  vms                 = var.vms_demo_int
  virtual_network_id  = data.azurerm_virtual_network.core_infra_vnet.id
  ports               = local.lb_ports
  tags                = module.ctags.common_tags
  expires_after       = var.env == "sandbox" ? local.expiresAfter : null
}