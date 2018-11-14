dataNodesAreMasterEligible = "Yes"
vmDataNodeCount = "3"
vmSizeAllNodes = "Standard_D1_v2"
storageAccountType = "Default"
vmDataDiskCount = "2"
// beware in changing these settings, data exposure risk
kibanaAdditionalYaml = "console.enabled: false\n"
esAdditionalYaml = "action.auto_create_index: .security*,.monitoring*,.watches,.triggered_watches,.watcher-history*,.logstash_dead_letter,.ml*\nxpack.monitoring.collection.enabled: true\nscript.allowed_types: none\nscript.allowed_contexts: none\n"




