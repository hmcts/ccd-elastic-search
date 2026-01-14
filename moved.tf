moved {
  from = azurerm_lb.this["demo"]
  to   = module.main_lb.azurerm_lb.this
}

moved {
  from = azurerm_lb_backend_address_pool.this["demo"]
  to   = module.main_lb.azurerm_lb_backend_address_pool.this
}

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
