locals {
  env_subs = {
    "prod" = "8999dec3-0104-4a27-94ee-6588559729d1"
  }
}


import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-0-prod-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-0"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-1-prod-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-2-prod-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-3-prod-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-3"]
}
# ============================================================================
# NIC Application Security Group Associations (4 resources)
# Defined in networking.tf as azurerm_network_interface_application_security_group_association.this
# ============================================================================

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-0"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-3"]
}

# ============================================================================
# NIC Network Security Group Associations (4 resources)
# Defined in networking.tf as azurerm_network_interface_security_group_association.association
# ============================================================================

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-0"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-3"]
}