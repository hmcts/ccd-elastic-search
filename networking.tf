resource "azurerm_application_security_group" "this" {
  name                = "ccd-data-asg"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  # Legacy: for environments using vms variable (e.g., AAT, prod, demo, perftest)
  for_each = length(var.elastic_search_clusters) > 0 ? {} : var.vms

  network_interface_id          = module.elastic2[each.key].nic_id
  application_security_group_id = azurerm_application_security_group.this.id
}

resource "azurerm_network_interface_application_security_group_association" "this_cluster" {
  # New cluster-based: for environments using elastic_search_clusters variable (e.g., ITHC)
  for_each = local.use_new_structure ? local.flattened_vms : {}

  network_interface_id          = module.elastic2_cluster[each.key].nic_id
  application_security_group_id = azurerm_application_security_group.this.id
}

resource "azurerm_network_interface_application_security_group_association" "this_demo_int" {

  for_each = var.enable_demo_int ? var.vms_demo_int : {}

  network_interface_id          = module.elastic2_demo_int[each.key].nic_id
  application_security_group_id = azurerm_application_security_group.this.id
}
resource "azurerm_network_security_group" "nsg_group" {
  name                = "ccd-cluster-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  tags = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = var.nsg_security_rules

  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.nsg_group.name

  name                       = each.value.name
  description                = each.value.description
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_port_ranges    = each.value.destination_port_ranges
  source_address_prefixes    = each.value.source_address_prefixes

  # Only set one of destination_address_prefix or destination_application_security_group_ids
  destination_address_prefix                 = each.value.destination_application_security_group_ids == "id" ? null : each.value.destination_address_prefix
  destination_application_security_group_ids = each.value.destination_application_security_group_ids == "id" ? [azurerm_application_security_group.this.id] : null

  source_application_security_group_ids      = each.value.source_application_security_group_ids == "id" ? [azurerm_application_security_group.this.id] : null
}

resource "azurerm_network_interface_security_group_association" "association" {
  # Legacy: for environments using vms variable (e.g., AAT, prod, demo, perftest)
  for_each = length(var.elastic_search_clusters) > 0 ? {} : var.vms

  network_interface_id      = module.elastic2[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}

resource "azurerm_network_interface_security_group_association" "association_cluster" {
  # New cluster-based: for environments using elastic_search_clusters variable (e.g., ITHC)
  for_each = local.use_new_structure ? local.flattened_vms : {}

  network_interface_id      = module.elastic2_cluster[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}

resource "azurerm_network_interface_security_group_association" "association_demo_int" {

  for_each = var.enable_demo_int ? var.vms_demo_int : {}

  network_interface_id      = module.elastic2_demo_int[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}