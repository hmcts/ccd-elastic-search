locals {
  perftest_subscription_id = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
}

# Resource Group
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest"
  to = azurerm_resource_group.this
}

# Load Balancer
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb"
  to = module.load_balancers["default"].azurerm_lb.this
}

# Key Vault Secrets
import {
  id = "https://ccd-perftest.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-URL"
  to = azurerm_key_vault_secret.elastic_search_url_key_setting
}

import {
  id = "https://ccd-perftest.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-DATA-NODES-URL"
  to = azurerm_key_vault_secret.es_data_nodes_url
}

# Backend Address Pool
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

# Load Balancer Probes
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/probes/es-probe-http-internal"
  to = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/probes/es-probe-transport-internal"
  to = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

# Load Balancer Rules
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/loadBalancingRules/es-transport-internal"
  to = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/loadBalancingRules/es-http-internal"
  to = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

# Backend Pool Addresses
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-0"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-1"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-2"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-3"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

# Application Security Group
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to = azurerm_application_security_group.this
}

# Network Security Group
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to = azurerm_network_security_group.nsg_group
}

# NSG Rules
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/ElasticClusterTransport"
  to = azurerm_network_security_rule.nsg_rules["ElasticClusterTransport"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/LB_To_ES"
  to = azurerm_network_security_rule.nsg_rules["LB_To_ES"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/AKS_To_ES"
  to = azurerm_network_security_rule.nsg_rules["AKS_To_ES"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/SSH"
  to = azurerm_network_security_rule.nsg_rules["SSH"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Bastion_To_ES"
  to = azurerm_network_security_rule.nsg_rules["Bastion_To_ES"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/DenyAllOtherTraffic"
  to = azurerm_network_security_rule.nsg_rules["DenyAllOtherTraffic"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Bastion_To_VMs"
  to = azurerm_network_security_rule.nsg_rules["Bastion_To_VMs"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/App_To_ES"
  to = azurerm_network_security_rule.nsg_rules["App_To_ES"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Mgmt_Perf_Test_To_ES"
  to = azurerm_network_security_rule.nsg_rules["Mgmt_Perf_Test_To_ES"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Jenkins_To_ES"
  to = azurerm_network_security_rule.nsg_rules["Jenkins_To_ES"]
}

# VM 0 Resources
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-0-datadisk1"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-0-datadisk2"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk1"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk2"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_availability_set.set[0]
}

# VM 1 Resources
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-1-datadisk1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-1-datadisk2"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk2"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_availability_set.set[0]
}

# VM 2 Resources
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-2-datadisk1"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-2-datadisk2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk1"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_availability_set.set[0]
}

# VM 3 Resources
import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-3-datadisk1"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-3-datadisk2"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk1"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk2"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription_id}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_availability_set.set[0]
}
