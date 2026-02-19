# Moved blocks for perftest environment migration from legacy to cluster structure

# Move load balancer from module.main_lb to module.load_balancers["default"]
moved {
  from = module.main_lb.azurerm_lb.this
  to   = module.load_balancers["default"].azurerm_lb.this
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

moved {
  from = module.main_lb.azurerm_lb_probe.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_rule.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_probe.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

moved {
  from = module.main_lb.azurerm_lb_rule.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}

# Move VM modules from module.elastic2 to module.elastic2_cluster
moved {
  from = module.elastic2["ccd-data-0"]
  to   = module.elastic2_cluster["ccd-data-0"]
}

moved {
  from = module.elastic2["ccd-data-1"]
  to   = module.elastic2_cluster["ccd-data-1"]
}

moved {
  from = module.elastic2["ccd-data-2"]
  to   = module.elastic2_cluster["ccd-data-2"]
}

moved {
  from = module.elastic2["ccd-data-3"]
  to   = module.elastic2_cluster["ccd-data-3"]
}

# Move data collection rule associations from linux_vm_dcra to linux_vm_dcra_cluster
moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-0"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-0"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-1"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-1"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-2"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-2"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-3"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-3"]
}

# Move network interface associations
moved {
  from = azurerm_network_interface_application_security_group_association.this["ccd-data-0"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-0"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this["ccd-data-1"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-1"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this["ccd-data-2"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-2"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this["ccd-data-3"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-3"]
}

# Move network security group associations
moved {
  from = azurerm_network_interface_security_group_association.association["ccd-data-0"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-0"]
}

moved {
  from = azurerm_network_interface_security_group_association.association["ccd-data-1"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-1"]
}

moved {
  from = azurerm_network_interface_security_group_association.association["ccd-data-2"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-2"]
}

moved {
  from = azurerm_network_interface_security_group_association.association["ccd-data-3"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-3"]
}
