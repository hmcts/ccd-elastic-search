######### resources which are DYNAMICALLY created by terraform ##################
#################################################################################
import {
  id = "/subscriptions/${var.subscription_id}/resourceGroups/ccd-elastic-search-${var.env}/providers/Microsoft.Network/loadBalancers/ccd-internal-${var.env}-lb"
  to = azurerm_lb.this["${var.env}"]
}

import {
  id = "/subscriptions/${var.subscription_id}/resourceGroups/ccd-elastic-search-${var.subscription_id}"
  to = "azurerm_resource_group.this"
}

################## resources which are spicific to the environment ##################
#################################################################################
import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-URL/ff4f0da523a34cacab5aeb78a38772c2"
  to = azurerm_key_vault_secret.elastic_search_url_key_setting
}

import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-DATA-NODES-URL/1ab689731b9e4e7da06ab9ce9c0c5d6a"
  to = azurerm_key_vault_secret.es_data_nodes_url
}

import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-vm-admin-name/86ec94f004794a3fa94ec20b5d572848"
  to = azurerm_key_vault_secret.admin_name
}



import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-vm-admin-password/b0a81ee0f879474aab47939e83bbb42a"
  to = azurerm_key_vault_secret.password
}

import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-vm-ssh-public-key/e260330fd08e48608ebc5f2a055a83ae"
  to = azurerm_key_vault_secret.ssh_public_key
}

import {
  id = "https://ccd-${var.env}.vault.azure.net/secrets/ccd-vm-ssh-private-key/363d2e9a4aa34b56baa3cd4522d0e588"
  to = azurerm_key_vault_secret.ssh_private_key
}
