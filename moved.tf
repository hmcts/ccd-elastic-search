# Moved statements to transition from legacy vms variable to elastic_search_clusters
# These statements ensure existing resources are not destroyed and recreated
#
# ITHC ONLY - These moves only apply when elastic_search_clusters is configured
#
# Usage:
# 1. Apply these moved blocks along with your new configuration
# 2. Run: terraform plan -var-file=ithc.tfvars
# 3. Verify that resources show as "moved" rather than "destroy/create"
# 4. Apply: terraform apply -var-file=ithc.tfvars
# 5. After successful apply, you can optionally remove this file (moved blocks are only needed once)

# Move VM module instances from old module.elastic2 to new module.elastic2_cluster
# Keys remain the same: "ccd-data-0", "ccd-data-1", etc.

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

# Move data collection rule associations to new cluster module
# Keys remain the same: "ccd-data-0", "ccd-data-1", etc.
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

# Move network interface application security group associations
# Keys remain the same: "ccd-data-0", "ccd-data-1", etc.
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

# Move network interface security group associations
# Keys remain the same: "ccd-data-0", "ccd-data-1", etc.
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

# Move load balancer resources from old module.main_lb to new module.load_balancers["default"]
# Cannot use module-level move because resource keys are changing
moved {
  from = module.main_lb.azurerm_lb.this
  to   = module.load_balancers["default"].azurerm_lb.this
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

# Move load balancer backend address pool addresses
# Keys remain the same: "ccd-data-0", "ccd-data-1", etc.
moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

# Move load balancer probes
moved {
  from = module.main_lb.azurerm_lb_probe.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_probe.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

# Move load balancer rules
moved {
  from = module.main_lb.azurerm_lb_rule.this["http"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_rule.this["transport"]
  to   = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}