locals {
  lb_ports = {
    "http" = {
      name       = "es-http-internal"
      port       = 9200
      probe_name = "es-probe-internal-http"
    }
    "transport" = {
      name       = "es-transport-internal"
      port       = 9300
      probe_name = "es-probe-transport-internal"
    }
  }
}

resource "azurerm_lb" "this" {
  #   count               = var.env == "sandbox" ? 1 : 0
  name                = "ccd-internal-${var.env}-lb"
  location            = var.location
  resource_group_name = "ccd-elastic-search-${var.env}"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LBFE"
    subnet_id                     = data.azurerm_subnet.elastic-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_address
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  #   count           = var.env == "sandbox" ? 1 : 0
  name            = "LBBE"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_backend_address_pool_address" "elastic_vm" {
  #   for_each                = var.env == "sandbox" ? var.vms : {}
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
  ip_address              = each.value.ip
  virtual_network_id      = data.azurerm_subnet.elastic-subnet.virtual_network_id
}


resource "azurerm_lb_probe" "this" {
  #   for_each        = var.env == "sandbox" ? local.lb_ports : {}
  name            = each.value.probe_name
  protocol        = "Tcp"
  port            = each.value.port
  loadbalancer_id = azurerm_lb.this[0].id
}

resource "azurerm_lb_rule" "this" {
  #   for_each                       = var.env == "sandbox" ? local.lb_ports : {}
  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = "LBFE"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this[0].id]
  probe_id                       = azurerm_lb_probe.this[each.key].id
  loadbalancer_id                = azurerm_lb.this[0].id
}
