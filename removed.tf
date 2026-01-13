removed {
  from = module.demo_int_lb[0].azurerm_lb.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool_address.this["ccd-data-int-0"]
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool_address.this["ccd-data-int-1"]
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool_address.this["ccd-data-int-2"]
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool_address.this["ccd-data-int-3"]
  lifecycle {
    destroy = false
  }
}
