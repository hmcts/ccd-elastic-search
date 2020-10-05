dataNodesAreMasterEligible = "Yes"
vmDataNodeCount            = "3"
vmSizeAllNodes             = "Standard_D1_v2"
storageAccountType         = "Default"
vmDataDiskCount            = "2"
dynatrace_instance         = "yrk32651"
dynatrace_hostgroup        = "Sbox_CFT"
dynatrace_token            = "${data.azurerm_key_vault_secret.dynatrace_token.value}"


aks_infra_subscription_id = "d025fece-ce99-4df2-b7a9-b649d3ff2060"