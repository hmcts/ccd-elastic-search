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

# Move VM module instances from old module.elastic2["ccd-data-X"] to new module.elastic2_cluster["default-X"]
# Old: module.elastic2 with vms variable keys: "ccd-data-0", "ccd-data-1", etc.
# New: module.elastic2_cluster with cluster keys: "default-0", "default-1", etc.

moved {
  from = module.elastic2["ccd-data-0"]
  to   = module.elastic2_cluster["default-0"]
}

moved {
  from = module.elastic2["ccd-data-1"]
  to   = module.elastic2_cluster["default-1"]
}

moved {
  from = module.elastic2["ccd-data-2"]
  to   = module.elastic2_cluster["default-2"]
}

moved {
  from = module.elastic2["ccd-data-3"]
  to   = module.elastic2_cluster["default-3"]
}

# Move data collection rule associations from old keys to new cluster module
moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-0"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["default-0"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-1"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["default-1"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-2"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["default-2"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-3"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["default-3"]
}

# Move load balancer from old module.main_lb to new module.load_balancers["default"]
# This applies to ITHC moving from single LB to cluster-based LB
moved {
  from = module.main_lb
  to   = module.load_balancers["default"]
}
