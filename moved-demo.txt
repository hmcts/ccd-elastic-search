moved {
  from = module.load_balancers["legacy"].azurerm_lb.this
  to   = module.main_lb.azurerm_lb.this
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool.this
  to   = module.main_lb.azurerm_lb_backend_address_pool.this
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_probe.this["http"]
  to   = module.main_lb.azurerm_lb_probe.this["http"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_rule.this["http"]
  to   = module.main_lb.azurerm_lb_rule.this["http"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_probe.this["transport"]
  to   = module.main_lb.azurerm_lb_probe.this["transport"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_rule.this["transport"]
  to   = module.main_lb.azurerm_lb_rule.this["transport"]
}
