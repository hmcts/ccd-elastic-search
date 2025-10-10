# Moved blocks to handle the refactoring from for_each to direct resources

moved {
  from = azurerm_lb.this["demo"]
  to   = azurerm_lb.this
}

moved {
  from = azurerm_lb_backend_address_pool.this["demo"]
  to   = azurerm_lb_backend_address_pool.this
}
