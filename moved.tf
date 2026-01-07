moved {
  from = module.elastic2_demo_int["ccd-data-int-0"]
  to   = module.elastic2_cluster["ccd-data-int-0"]
}

moved {
  from = module.elastic2_demo_int["ccd-data-int-1"]
  to   = module.elastic2_cluster["ccd-data-int-1"]
}

moved {
  from = module.elastic2_demo_int["ccd-data-int-2"]
  to   = module.elastic2_cluster["ccd-data-int-2"]
}

moved {
  from = module.elastic2_demo_int["ccd-data-int-3"]
  to   = module.elastic2_cluster["ccd-data-int-3"]
}


moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_demo_int["ccd-data-int-0"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-int-0"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_demo_int["ccd-data-int-1"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-int-1"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_demo_int["ccd-data-int-2"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-int-2"]
}

moved {
  from = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_demo_int["ccd-data-int-3"]
  to   = azurerm_monitor_data_collection_rule_association.linux_vm_dcra_cluster["ccd-data-int-3"]
}


moved {
  from = azurerm_network_interface_application_security_group_association.this_demo_int["ccd-data-int-0"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-int-0"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this_demo_int["ccd-data-int-1"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-int-1"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this_demo_int["ccd-data-int-2"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-int-2"]
}

moved {
  from = azurerm_network_interface_application_security_group_association.this_demo_int["ccd-data-int-3"]
  to   = azurerm_network_interface_application_security_group_association.this_cluster["ccd-data-int-3"]
}


moved {
  from = azurerm_network_interface_security_group_association.association_demo_int["ccd-data-int-0"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-int-0"]
}

moved {
  from = azurerm_network_interface_security_group_association.association_demo_int["ccd-data-int-1"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-int-1"]
}

moved {
  from = azurerm_network_interface_security_group_association.association_demo_int["ccd-data-int-2"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-int-2"]
}

moved {
  from = azurerm_network_interface_security_group_association.association_demo_int["ccd-data-int-3"]
  to   = azurerm_network_interface_security_group_association.association_cluster["ccd-data-int-3"]
}


moved {
  from = module.demo_int_lb[0].azurerm_lb.this
  to   = module.load_balancers["demo_int"].azurerm_lb.this
}

moved {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["demo_int"].azurerm_lb_backend_address_pool.this
}

moved {
  from = module.demo_int_lb[0].azurerm_lb_backend_address_pool_address.this
  to   = module.load_balancers["demo_int"].azurerm_lb_backend_address_pool_address.this
}

moved {
  from = module.demo_int_lb[0].azurerm_lb_probe.this
  to   = module.load_balancers["demo_int"].azurerm_lb_probe.this
}

moved {
  from = module.demo_int_lb[0].azurerm_lb_rule.this
  to   = module.load_balancers["demo_int"].azurerm_lb_rule.this
}


moved {
  from = azurerm_resource_group.demo_int[0]
  to   = azurerm_resource_group.cluster_rgs["demo_int"]
}

moved {
  from = module.main_lb.azurerm_lb.this
  to   = module.load_balancers["legacy"].azurerm_lb.this
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool.this
  to   = module.load_balancers["legacy"].azurerm_lb_backend_address_pool.this
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
  to   = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-0"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
  to   = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-1"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
  to   = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-2"]
}

moved {
  from = module.main_lb.azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
  to   = module.load_balancers["legacy"].azurerm_lb_backend_address_pool_address.this["ccd-data-3"]
}

moved {
  from = module.main_lb.azurerm_lb_probe.this["http"]
  to   = module.load_balancers["legacy"].azurerm_lb_probe.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_probe.this["transport"]
  to   = module.load_balancers["legacy"].azurerm_lb_probe.this["transport"]
}

moved {
  from = module.main_lb.azurerm_lb_rule.this["http"]
  to   = module.load_balancers["legacy"].azurerm_lb_rule.this["http"]
}

moved {
  from = module.main_lb.azurerm_lb_rule.this["transport"]
  to   = module.load_balancers["legacy"].azurerm_lb_rule.this["transport"]
}

import {
  to = module.elastic2_cluster["ccd-data-int2-0"].module.virtual-machines.azurerm_availability_set.set[0]
  id = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/ccd-elastic-search-demo-int2/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET-INT2"
}

import {
  to = module.elastic2_cluster["ccd-data-int2-1"].module.virtual-machines.azurerm_availability_set.set[0]
  id = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/ccd-elastic-search-demo-int2/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET-INT2"
}

import {
  to = module.elastic2_cluster["ccd-data-int2-2"].module.virtual-machines.azurerm_availability_set.set[0]
  id = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/ccd-elastic-search-demo-int2/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET-INT2"
}

import {
  to = module.elastic2_cluster["ccd-data-int2-3"].module.virtual-machines.azurerm_availability_set.set[0]
  id = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/ccd-elastic-search-demo-int2/providers/Microsoft.Compute/availabilitySets/CCD-DATA-0-AV-SET-INT2"
}
