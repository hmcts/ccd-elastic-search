# Moved statements to transition from legacy vms variable to elastic_search_clusters
# These statements ensure existing resources are not destroyed and recreated
# 
# Usage:
# 1. Apply these moved blocks along with your new configuration
# 2. Run: terraform plan -var-file=sandbox.tfvars
# 3. Verify that resources show as "moved" rather than "destroy/create"
# 4. Apply: terraform apply -var-file=sandbox.tfvars
# 5. After successful apply, you can optionally remove this file (moved blocks are only needed once)

# Move VM module instances from old keys to new flattened keys
# Old key format: "ccd-data-0", "ccd-data-1", etc.
# New key format: "default-0", "default-1", etc.

moved {
  from = module.elastic2["ccd-data-0"]
  to   = module.elastic2["default-0"]
}

moved {
  from = module.elastic2["ccd-data-1"]
  to   = module.elastic2["default-1"]
}

moved {
  from = module.elastic2["ccd-data-2"]
  to   = module.elastic2["default-2"]
}

moved {
  from = module.elastic2["ccd-data-3"]
  to   = module.elastic2["default-3"]
}

# Move data collection rule associations
moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-0"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["default-0"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-1"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["default-1"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-2"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["default-2"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-3"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["default-3"]
}

# Move load balancer from module.main_lb to module.load_balancers["legacy"]
# Note: This will only work if you still have the old vms variable defined
# If you've removed the vms variable, the load balancer will move to module.load_balancers["default"]
# and you should update the from address accordingly

moved {
  from = module.main_lb
  to   = module.load_balancers["default"]
}

# Note: If you have kept the vms variable temporarily for backward compatibility,
# the load balancer will be under module.load_balancers["legacy"]
# In that case, use this instead:
# moved {
#   from = module.main_lb
#   to   = module.load_balancers["legacy"]
# }
# 
# After the first apply, change it to move from legacy to default:
# moved {
#   from = module.load_balancers["legacy"]
#   to   = module.load_balancers["default"]
# }
