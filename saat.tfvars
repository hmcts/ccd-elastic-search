dataNodesAreMasterEligible = "Yes"
vmDataNodeCount = "2"
kibanaAdditionalYaml = "console.enabled: true\n"
esAdditionalYaml = "action.auto_create_index: .security*,.monitoring*,.watches,.triggered_watches,.watcher-history*,.kibana*,.logstash_dead_letter,.ml*\nxpack.monitoring.collection.enabled: true\nscript.allowed_types: none\nscript.allowed_contexts: none\n"
