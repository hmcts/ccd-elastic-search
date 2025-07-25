locals {
  enabled_lb_envs = ["sandbox", "demo"]
  is_enabled_env  = contains(local.enabled_lb_envs, var.env)
  env_map         = local.is_enabled_env ? { (var.env) = true } : {}

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

resource "azurerm_lb" "this" {
  for_each            = local.env_map
  name                = "ccd-internal-${var.env}-lb"
  location            = var.location
  resource_group_name = "ccd-elastic-search-${var.env}"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LBFE"
    subnet_id                     = data.azurerm_subnet.elastic-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_address
    zones                         = ["1", "2", "3"]
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  for_each        = local.env_map
  name            = "LBBE"
  loadbalancer_id = azurerm_lb.this[each.key].id
}

resource "azurerm_lb_backend_address_pool_address" "elastic_vm" {
  for_each                = local.is_enabled_env ? var.vms : {}
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.this[var.env].id
  ip_address              = each.value.ip
  virtual_network_id      = data.azurerm_virtual_network.core_infra_vnet.id
}

resource "azurerm_lb_probe" "this" {
  for_each            = local.is_enabled_env ? local.lb_ports : {}
  name                = each.value.probe_name
  protocol            = "Tcp"
  port                = each.value.port
  loadbalancer_id     = azurerm_lb.this[var.env].id
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "this" {
  for_each                       = local.is_enabled_env ? local.lb_ports : {}
  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = "LBFE"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this[var.env].id]
  probe_id                       = azurerm_lb_probe.this[each.key].id
  loadbalancer_id                = azurerm_lb.this[var.env].id
  disable_outbound_snat          = true
}
