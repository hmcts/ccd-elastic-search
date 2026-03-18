resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = var.frontend_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.ip_address
    zones                         = ["1", "2", "3"]
  }

  tags = merge(var.tags, var.expires_after != null ? { expiresAfter = var.expires_after } : {})
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = var.backend_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_backend_address_pool_address" "this" {
  for_each = var.vms

  name                    = try(each.value.name, each.key)
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
  ip_address              = each.value.ip
  virtual_network_id      = var.virtual_network_id
}

resource "azurerm_lb_probe" "this" {
  for_each = var.ports

  name                = each.value.probe_name
  protocol            = "Tcp"
  port                = each.value.port
  loadbalancer_id     = azurerm_lb.this.id
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "this" {
  for_each = var.ports

  name                           = each.value.name
  protocol                       = "Tcp"
  frontend_port                  = each.value.port
  backend_port                   = each.value.port
  frontend_ip_configuration_name = var.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this[each.key].id
  loadbalancer_id                = azurerm_lb.this.id
  disable_outbound_snat          = true
}
