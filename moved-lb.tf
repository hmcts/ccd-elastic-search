moved {
  from = azurerm_lb.this["demo"]
  to   = module.main_lb.azurerm_lb.this
}

moved {
  from = azurerm_lb_backend_address_pool.this["demo"]
  to   = module.main_lb.azurerm_lb_backend_address_pool.this
}

moved {
  from = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-0"]
  to   = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

moved {
  from = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-1"]
  to   = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

moved {
  from = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-2"]
  to   = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

moved {
  from = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-3"]
  to   = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

moved {
  from = azurerm_lb_probe.this["http"]
  to   = module.main_lb.azurerm_lb_probe.this["http"]
}

moved {
  from = azurerm_lb_probe.this["transport"]
  to   = module.main_lb.azurerm_lb_probe.this["transport"]
}

moved {
  from = azurerm_lb_rule.this["http"]
  to   = module.main_lb.azurerm_lb_rule.this["http"]
}

moved {
  from = azurerm_lb_rule.this["transport"]
  to   = module.main_lb.azurerm_lb_rule.this["transport"]
}