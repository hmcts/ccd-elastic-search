resource "azurerm_application_security_group" "this" {
  name                = "ccd-data-asg"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  for_each                      = var.env == "sandbox" ? var.vms : {}
  network_interface_id          = module.elastic2[each.key].nic_id
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
  destination_address_prefix = each.value.destination_address_prefix

  source_application_security_group_ids      = each.value.source_application_security_group_ids == "id" ? [azurerm_application_security_group.this.id] : null
  destination_application_security_group_ids = each.value.destination_application_security_group_ids == "id" ? [azurerm_application_security_group.this.id] : null
}

resource "azurerm_network_interface_security_group_association" "association" {
  for_each                  = var.env == "sandbox" ? var.vms : {}
  network_interface_id      = module.elastic2[each.key].nic_id
  network_security_group_id = azurerm_network_security_group.nsg_group.id
}
