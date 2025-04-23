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
