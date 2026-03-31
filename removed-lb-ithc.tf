# Temporary removed blocks for ITHC load balancer state cleanup.
# These are intended to stop Terraform refreshing missing LB resources that still exist in state.
# Remove this file when re-enabling LB creation/management for ITHC.

removed {
  from = module.load_balancers["default"].azurerm_lb.this
}

removed {
  from = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

removed {
  from = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

removed {
  from = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}
