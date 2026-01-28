locals {
  env_subs = {
    "ithc" = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
  }
}

import {
  for_each = { for k, v in local.env_subs : k => v if k == "ithc" }
  to = azurerm_resource_group.cluster["upgrade"]
  id = "/subscriptions/${each.value}/resourceGroups/ccd-elastic-search-upgrade-${each.key}"
}
