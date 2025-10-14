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

resource "azurerm_lb" "this" {
  name                = "ccd-internal-${var.env}-lb"
  location            = var.location
  resource_group_name = "ccd-elastic-search-${var.env}"

  sku = "Standard"

  frontend_ip_configuration {
    name                          = "LBFE"
    subnet_id                     = data.azurerm_subnet.elastic-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_address

    zones = ["1", "2", "3"]

  }
  tags = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "LBBE"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_backend_address_pool_address" "elastic_vm" {
  for_each                = var.vms
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
  ip_address              = each.value.ip
  virtual_network_id      = data.azurerm_virtual_network.core_infra_vnet.id
}

resource "azurerm_lb_probe" "this" {

  for_each            = local.lb_ports
  name                = each.value.probe_name
  protocol            = "Tcp"
  port                = each.value.port
  loadbalancer_id     = azurerm_lb.this.id
  interval_in_seconds = 5
  number_of_probes    = 2

}

resource "azurerm_lb_rule" "this" {
  for_each                       = local.lb_ports
  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = "LBFE"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this[each.key].id
  loadbalancer_id                = azurerm_lb.this.id

  disable_outbound_snat = true
}

# demo-int lb
resource "azurerm_lb" "demo_int" {
  count               = var.enable_demo_int ? 1 : 0
  name                = "ccd-internal-demo-int-lb"
  location            = var.location
  resource_group_name = var.demo_int_rg_name

  sku = "Standard"

  frontend_ip_configuration {
    name                          = "LBFE-DEMO-INT"
    subnet_id                     = data.azurerm_subnet.elastic-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_address_demo_int

    zones = ["1", "2", "3"]
  }
  tags = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_lb_backend_address_pool" "demo_int" {
  count           = var.enable_demo_int ? 1 : 0
  name            = "LBBE-DEMO-INT"
  loadbalancer_id = azurerm_lb.demo_int[0].id
}

resource "azurerm_lb_backend_address_pool_address" "elastic_vm_demo_int" {
  for_each                = var.enable_demo_int ? var.vms_demo_int : {}
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.demo_int[0].id
  ip_address              = each.value.ip
  virtual_network_id      = data.azurerm_virtual_network.core_infra_vnet.id
}

resource "azurerm_lb_probe" "demo_int" {
  for_each            = var.enable_demo_int ? local.lb_ports : {}
  name                = "${each.value.probe_name}-demo-int"
  protocol            = "Tcp"
  port                = each.value.port
  loadbalancer_id     = azurerm_lb.demo_int[0].id
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "demo_int" {
  for_each                       = var.enable_demo_int ? local.lb_ports : {}
  name                           = "${each.value.name}-demo-int"
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = "LBFE-DEMO-INT"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.demo_int[0].id]
  probe_id                       = azurerm_lb_probe.demo_int[each.key].id
  loadbalancer_id                = azurerm_lb.demo_int[0].id

  disable_outbound_snat = true
}
