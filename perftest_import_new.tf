locals {
  perftest_subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
}

# Moved blocks for load balancer refactoring from main_lb module to load_balancers["default"]
moved {
  from = module.main_lb.azurerm_lb.this
  to   = module.load_balancers["default"].azurerm_lb.this
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["default"].azurerm_lb_backend_address_pool.this
}

# Load Balancer Probes - import existing
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/probes/es-probe-http-internal"
  to = module.load_balancers["default"].azurerm_lb_probe.this["http"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/probes/es-probe-transport-internal"
  to = module.load_balancers["default"].azurerm_lb_probe.this["transport"]
}

# Load Balancer Rules - import existing
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/loadBalancingRules/es-http-internal"
  to = module.load_balancers["default"].azurerm_lb_rule.this["http"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/loadBalancingRules/es-transport-internal"
  to = module.load_balancers["default"].azurerm_lb_rule.this["transport"]
}

# Backend Pool Addresses - import existing
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-0"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-1"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-2"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/loadBalancers/ccd-internal-perftest-lb/backendAddressPools/LBBE/addresses/ccd-data-3"
  to = module.load_balancers["default"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

# Network Interfaces
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_network_interface.vm_nic
}

# Virtual Machines
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

# Managed Disks - ccd-data-0
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-0-datadisk1"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-0-datadisk2"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# Managed Disks - ccd-data-1
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-1-datadisk1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-1-datadisk2"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# Managed Disks - ccd-data-2
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-2-datadisk1"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-2-datadisk2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# Managed Disks - ccd-data-3
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-3-datadisk1"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/disks/ccd-data-3-datadisk2"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# Data Disk Attachments - ccd-data-0
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk1"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk2"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

# Data Disk Attachments - ccd-data-1
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk1"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk2"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

# Data Disk Attachments - ccd-data-2
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk1"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk2"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

# Data Disk Attachments - ccd-data-3
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk1"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk2"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

# Availability Sets - all VMs share the same availability set
import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-0"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-1"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-2"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  id = "/subscriptions/${local.perftest_subscription}/resourceGroups/ccd-elastic-search-perftest/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to = module.elastic2_cluster["ccd-data-3"].module.virtual-machines.azurerm_availability_set.set[0]
}
