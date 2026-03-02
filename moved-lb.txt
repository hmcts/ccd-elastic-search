# Moved blocks for load balancer refactoring from "legacy" to "default" key

# Load Balancer
moved {
  from = module.load_balancers["legacy"].azurerm_lb.this
  to   = module.load_balancers["default"].azurerm_lb.this
}

# Backend Address Pool
moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

# Backend Address Pool Addresses
moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

# Probes
moved {
  from = module.load_balancers["legacy"].azurerm_lb_probe.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_probe.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

# Load Balancing Rules
moved {
  from = module.load_balancers["legacy"].azurerm_lb_rule.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

moved {
  from = module.load_balancers["legacy"].azurerm_lb_rule.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}