# prod_imports2.tf - Remaining imports for production environment
# Based on terraform apply failures from 2026-01-12

locals {
  env_subs = {
    "prod" = "8999dec3-0104-4a27-94ee-6588559729d1"
  }
}

# ============================================================================
# Data Collection Rule Associations (4 resources)
# These failed with "already exists" errors and need to be imported
# ============================================================================

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-0-dcra"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-1-dcra"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-2-dcra"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-3-dcra"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

# ============================================================================
# Role Assignments (8 resources)
# ============================================================================

# VM: ccd-data-0
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Authorization/roleAssignments/0c37284e-77d7-9e75-e16c-6ebeb7deb9a6"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_role_assignment.admin-user["standard"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Authorization/roleAssignments/f48b0d4e-c041-7ea7-2dd8-862518f1b392"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_role_assignment.admin-user["sudo"]
}

# VM: ccd-data-1
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Authorization/roleAssignments/89764812-5d1f-47fa-8293-720c24b6334d"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_role_assignment.admin-user["standard"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Authorization/roleAssignments/104763f1-155e-98f2-0010-ad00cbe63d13"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_role_assignment.admin-user["sudo"]
}

# VM: ccd-data-2
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Authorization/roleAssignments/8c925986-2506-9636-9eaa-dede44406f3a"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_role_assignment.admin-user["standard"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Authorization/roleAssignments/a94bb660-4fd3-5f29-f7fb-6e225fd52a9d"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_role_assignment.admin-user["sudo"]
}

# VM: ccd-data-3
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Authorization/roleAssignments/84fb0e5c-e2c2-1a3c-c72c-85ea8ae25f7c"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_role_assignment.admin-user["standard"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Authorization/roleAssignments/9cc6b329-1cfb-fd34-ed5a-a8cad6c54c63"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_role_assignment.admin-user["sudo"]
}