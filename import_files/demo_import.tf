locals {
  env_subs = {
    "demo" = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
  }
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb"
  to       = azurerm_lb.this["${each.key}"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}"
  to       = azurerm_resource_group.this
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-URL/ff4f0da523a34cacab5aeb78a38772c2"
  to       = azurerm_key_vault_secret.elastic_search_url_key_setting
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-DATA-NODES-URL/1ab689731b9e4e7da06ab9ce9c0c5d6a"
  to       = azurerm_key_vault_secret.es_data_nodes_url
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-admin-name/86ec94f004794a3fa94ec20b5d572848"
  to       = azurerm_key_vault_secret.admin_name
}

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-ssh-public-key/e260330fd08e48608ebc5f2a055a83ae"
#   to       = azurerm_key_vault_secret.ssh_public_key
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-ssh-private-key/363d2e9a4aa34b56baa3cd4522d0e588"
#   to       = azurerm_key_vault_secret.ssh_private_key
# }


# ...existing code...

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE"
  to       = azurerm_lb_backend_address_pool.this["${each.key}"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/probes/es-probe-http-internal"
  to       = azurerm_lb_probe.this["http"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/probes/es-probe-transport-internal"
  to       = azurerm_lb_probe.this["transport"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_application_security_group.this
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_security_group.nsg_group
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_network_interface.vm_nic
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_network_interface.vm_nic
}

# ...existing code...


# ...existing code...

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-0"
  to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-0"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-1"
  to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-2"
  to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/ccd-data-3"
  to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-3"]
}

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/fae6188c-0191-4921-8cad-fab6ae8a6df8"
#   to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-0"]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/c26b501e-69b4-4f41-a8f3-2c1b57c57b87"
#   to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-1"]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/bc5d2e57-5201-4713-9bfc-7ba386ef0dae"
#   to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-2"]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/backendAddressPools/LBBE/addresses/2d46fec0-5eed-416b-b367-6e5d47d53bde"
#   to       = azurerm_lb_backend_address_pool_address.elastic_vm["ccd-data-3"]
# }

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/loadBalancingRules/es-transport-internal"
  to       = azurerm_lb_rule.this["transport"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb/loadBalancingRules/es-http-internal"
  to       = azurerm_lb_rule.this["http"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/ElasticClusterTransport"
  to       = azurerm_network_security_rule.nsg_rules["ElasticClusterTransport"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/LB_To_ES"
  to       = azurerm_network_security_rule.nsg_rules["LB_To_ES"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/AKS_To_ES"
  to       = azurerm_network_security_rule.nsg_rules["AKS_To_ES"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/SSH"
  to       = azurerm_network_security_rule.nsg_rules["SSH"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Bastion_To_ES"
  to       = azurerm_network_security_rule.nsg_rules["Bastion_To_ES"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/DenyAllOtherTraffic"
  to       = azurerm_network_security_rule.nsg_rules["DenyAllOtherTraffic"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Bastion_To_VMs"
  to       = azurerm_network_security_rule.nsg_rules["Bastion_To_VMs"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/App_To_ES"
  to       = azurerm_network_security_rule.nsg_rules["App_To_ES"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/Jenkins_To_ES"
  to       = azurerm_network_security_rule.nsg_rules["Jenkins_To_ES"]
}

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg/securityRules/cft-ptlsbox"
#   to       = azurerm_network_security_rule.nsg_rules["cft-ptlsbox"]
# }

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_linux_virtual_machine.linvm[0]
}

# ...existing code...


# ...existing code...

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/extensions/AMALinux"
#   to       = module.elastic2["ccd-data-0"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.azure_monitor[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/extensions/AMALinux"
#   to       = module.elastic2["ccd-data-1"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.azure_monitor[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/extensions/AMALinux"
#   to       = module.elastic2["ccd-data-2"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.azure_monitor[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/extensions/AMALinux"
#   to       = module.elastic2["ccd-data-3"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.azure_monitor[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/extensions/HMCTSBootstrapScript"
#   to       = module.elastic2["ccd-data-0"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.custom_script[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/extensions/HMCTSBootstrapScript"
#   to       = module.elastic2["ccd-data-1"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.custom_script[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/extensions/HMCTSBootstrapScript"
#   to       = module.elastic2["ccd-data-2"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.custom_script[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/extensions/HMCTSBootstrapScript"
#   to       = module.elastic2["ccd-data-3"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.custom_script[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/extensions/Dynatrace"
#   to       = module.elastic2["ccd-data-0"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.dynatrace_oneagent[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/extensions/Dynatrace"
#   to       = module.elastic2["ccd-data-1"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.dynatrace_oneagent[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/extensions/Dynatrace"
#   to       = module.elastic2["ccd-data-2"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.dynatrace_oneagent[0]
# }

# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/extensions/Dynatrace"
#   to       = module.elastic2["ccd-data-3"].module.virtual-machines.module.vm-bootstrap[0].azurerm_virtual_machine_extension.dynatrace_oneagent[0]
# }



# import {
#   for_each = { for k, v in local.env_subs : k => v if k == "demo" }
#   id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/extensions/AADSSHLoginForLinux"
#   to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_extension.entra[0]
# }

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-0-dcra"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-1-dcra"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-2-dcra"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-3-dcra"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.module.vm-bootstrap[0].azurerm_monitor_data_collection_rule_association.linux_vm_dcra[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-0-datadisk1"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-0-datadisk2"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-1-datadisk1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-1-datadisk2"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-2-datadisk1"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-2-datadisk2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-3-datadisk1"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/disks/ccd-data-3-datadisk2"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_managed_disk.managed_disks["disk2"]
}

# ...existing code...

# ...existing code...

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk1"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/dataDisks/ccd-data-0-datadisk2"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk1"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/dataDisks/ccd-data-1-datadisk2"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk1"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/dataDisks/ccd-data-2-datadisk2"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk1"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk1"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/dataDisks/ccd-data-3-datadisk2"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_virtual_machine_data_disk_attachment.data_disk_attachments["disk2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-0"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-1"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-2"].module.virtual-machines.azurerm_availability_set.set[0]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET"
  to       = module.elastic2["ccd-data-3"].module.virtual-machines.azurerm_availability_set.set[0]
}

# ...existing code...

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-0"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-1"]
}


import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-2"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/applicationSecurityGroups/ccd-data-asg"
  to       = azurerm_network_interface_application_security_group_association.this["ccd-data-3"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-0-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-0"]
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-1-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-1"]
}
import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-2-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-2"]
}
import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkInterfaces/ccd-data-3-nic|/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/networkSecurityGroups/ccd-cluster-nsg"
  to       = azurerm_network_interface_security_group_association.association["ccd-data-3"]
}


import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-0/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-0-${each.key}-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-0"]
}
import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-1/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-1-${each.key}-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-1"]
}
import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-2/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-2-${each.key}-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-2"]
}
import {
  for_each = { for k, v in local.env_subs : k => v if k == "demo" }
  id       = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Compute/virtualMachines/ccd-data-3/providers/Microsoft.Insights/dataCollectionRuleAssociations/vm-ccd-data-3-${each.key}-dcra"
  to       = azurerm_monitor_data_collection_rule_association.linux_vm_dcra["ccd-data-3"]
}
