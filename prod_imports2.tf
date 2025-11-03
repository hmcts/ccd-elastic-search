# prod_imports2.tf - Import blocks for resources to be created for production environment
# Based on the Terraform plan output showing resources to be created

locals {
  env_subs = {
    "prod" = "8999dec3-0104-4a27-94ee-6588559729d1"
  }
}

# Load Balancer Backend Address Pool Addresses (now in main_lb module)
# Note: Load balancer, backend pool, probes, and rules are handled by moved blocks in moved-lb-prod.tf
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-0"
  to       = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-1"
  to       = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-2"
  to       = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-3"
  to       = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

# Monitor Data Collection Rule Associations (Top-level resources)
# Note: These need to be scoped to the VM, not at resource group level
# Removing import blocks as the paths were incorrect and these will be created instead

# Virtual Machines
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

# Availability Sets
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_availability_set.set[0]
}

# Network Interfaces
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_network_interface.vm_nic
}

# Managed Disks - Data Disk 1
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-0-datadisk1"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-1-datadisk1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-2-datadisk1"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-3-datadisk1"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

# Managed Disks - Data Disk 2
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-0-datadisk2"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-1-datadisk2"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-2-datadisk2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-3-datadisk2"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# Virtual Machine Data Disk Attachments - Disk 1
# Note: ccd-data-0 disk1 attachment shows "must be replaced" due to create_option mismatch
# This is unavoidable - the existing attachment has create_option="Attach" but Terraform expects "Empty"
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk1"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk1"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk1"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

# Virtual Machine Data Disk Attachments - Disk 2
# Note: ccd-data-3 disk2 attachment shows "must be replaced" due to create_option mismatch
# This is unavoidable - the existing attachment has create_option="Attach" but Terraform expects "Empty"
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk2"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk2"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk2"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

# Role Assignments - Standard and Sudo
# Note: All role assignments are failing import due to invalid GUID format
# These resources will be created, not imported
# Role assignment IDs must be actual GUIDs, not descriptive names like 'ccd-data-X-standard-role'

# VM Extensions - Entra ID (AADSSHLoginForLinux)
# Note: Only ccd-data-0, ccd-data-1, and ccd-data-2 exist and need to be imported
# ccd-data-3 will be created (not imported)
import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/extensions/AADSSHLoginForLinux"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_extension.entra[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/extensions/AADSSHLoginForLinux"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_extension.entra[0]
}

import {
  for_each = var.env == "prod" ? { for k, v in local.env_subs : k => v if k == "prod" } : {}
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/extensions/AADSSHLoginForLinux"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_extension.entra[0]
}

# VM Extensions - Azure Monitor Agent (AMALinux) from vm-bootstrap module
# Note: Import failed for ccd-data-1 and ccd-data-2 - these extensions don't exist
# All AMA extensions will be created, not imported

# VM Extensions - Custom Script (HMCTSBootstrapScript) from vm-bootstrap module
# Note: Import failed for all VMs - these extensions don't exist
# All custom script extensions will be created, not imported

# VM Extensions - Dynatrace OneAgent from vm-bootstrap module
# Note: No existing Dynatrace extensions to import - all will be created
# ccd-data-1, ccd-data-2, and ccd-data-3 will be created (not imported)
# ccd-data-0 doesn't get Dynatrace according to the plan

# Monitor Data Collection Rule Associations from vm-bootstrap module
# Note: These show "must be replaced" in the plan, so they will be destroyed and recreated
# No import blocks needed as they will be recreated with new names

# Note: Role assignment IDs will need to be updated after the resources are created
# since they are generated during resource creation. The placeholders above should be
# replaced with the actual role assignment IDs generated by Azure.
#
# To get the actual role assignment IDs, run:
# az role assignment list --scope /subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourceGroups/ccd-elastic-search-prod/providers/Microsoft.Compute/virtualMachines/ccd-data-X