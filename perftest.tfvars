dataNodesAreMasterEligible = "Yes"
vmDataNodeCount = "3"
vmSizeAllNodes = "Standard_D2_v2"
storageAccountType = "Default"
vmDataDiskCount = "2"
dynatrace_instance = "yrk32651"
dynatrace_hostgroup = "PERF_CFT"
dynatrace_token = "${data.azurerm_key_vault_secret.dynatrace_token.value}"


aks_infra_subscription_id = "8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c"