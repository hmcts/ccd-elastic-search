######### resources which are DYNAMICALLY created by terraform ##################
#################################################################################
import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "/subscriptions/${each.key.value}/resourceGroups/ccd-elastic-search-${each.key}/providers/Microsoft.Network/loadBalancers/ccd-internal-${each.key}-lb"
  to       = azurerm_lb.this["${each.key}"]
}

import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "/subscriptions/${each.key.value}/resourceGroups/ccd-elastic-search-${each.key.value}"
  to       = azurerm_resource_group.this
}

################## resources which are spicific to the environment ##################
#################################################################################
import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-URL/ff4f0da523a34cacab5aeb78a38772c2"
  to       = azurerm_key_vault_secret.elastic_search_url_key_setting
}

import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-ELASTIC-SEARCH-DATA-NODES-URL/1ab689731b9e4e7da06ab9ce9c0c5d6a"
  to       = azurerm_key_vault_secret.es_data_nodes_url
}

import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-admin-name/86ec94f004794a3fa94ec20b5d572848"
  to       = azurerm_key_vault_secret.admin_name
}



import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-admin-password/b0a81ee0f879474aab47939e83bbb42a"
  to       = azurerm_key_vault_secret.password
}

import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-ssh-public-key/e260330fd08e48608ebc5f2a055a83ae"
  to       = azurerm_key_vault_secret.ssh_public_key
}

import {
  for_each = { for k, v in local.env_map : k => v if k == var.env }
  id       = "https://ccd-${each.key}.vault.azure.net/secrets/ccd-vm-ssh-private-key/363d2e9a4aa34b56baa3cd4522d0e588"
  to       = azurerm_key_vault_secret.ssh_private_key
}
