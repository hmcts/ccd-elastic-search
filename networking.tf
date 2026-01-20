# Legacy ASG for old vms variable and default cluster
resource "azurerm_application_security_group" "this" {
  name                = "ccd-data-asg"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

# ASG per cluster in elastic_search_clusters (excluding default which uses legacy)
resource "azurerm_application_security_group" "cluster" {
  for_each = { for k, v in var.elastic_search_clusters : k => v if k != "default" }

  name                = "ccd-data-${each.key}-asg"
  location            = var.location
  resource_group_name = coalesce(
    each.value.resource_group_name,
    each.key == "upgrade" ? "ccd-elastic-search-upgrade-${var.env}" : "ccd-elastic-search-${var.env}"
  )
  tags = merge(module.ctags.common_tags, var.env == "sandbox" ? { expiresAfter = local.expiresAfter } : {})
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  for_each = length(var.elastic_search_clusters) > 0 ? {} : var.vms

  network_interface_id          = module.elastic2[each.key].nic_id
  application_security_group_id = azurerm_application_security_group.this.id
}

resource "azurerm_network_interface_application_security_group_association" "this_cluster" {
  for_each = local.use_new_structure ? local.flattened_vms : {}

  network_interface_id          = module.elastic2_cluster[each.key].nic_id
  application_security_group_id = each.value.cluster_key == "default" ? azurerm_application_security_group.this.id : azurerm_application_security_group.cluster[each.value.cluster_key].id
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

  name                    = each.value.name
  description             = each.value.description
  priority                = each.value.priority
  direction               = each.value.direction
  access                  = each.value.access
  protocol                = each.value.protocol
  source_port_range       = each.value.source_port_range
  destination_port_range  = each.value.destination_port_range
  source_address_prefix   = each.value.source_address_prefix
  destination_port_ranges = each.value.destination_port_ranges
  source_address_prefixes = each.value.source_address_prefixes

  # Only set one of destination_address_prefix or destination_application_security_group_ids
  destination_address_prefix = each.value.destination_application_security_group_ids == "id" ? null : each.value.destination_address_prefix
  destination_application_security_group_ids = each.value.destination_application_security_group_ids == "id" ? concat(
    [azurerm_application_security_group.this.id],
    [for asg in azurerm_application_security_group.cluster : asg.id]
  ) : null

  source_application_security_group_ids = each.value.source_application_security_group_ids == "id" ? concat(
    [azurerm_application_security_group.this.id],
    [for asg in azurerm_application_security_group.cluster : asg.id]
  ) : null
}

resource "azurerm_network_interface_security_group_association" "association" {
  for_each = length(var.elastic_search_clusters) > 0 ? {} : var.vms

  network_interface_id      = module.elastic2[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}

resource "azurerm_network_interface_security_group_association" "association_cluster" {
  for_each = local.use_new_structure ? local.flattened_vms : {}

  network_interface_id      = module.elastic2_cluster[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}