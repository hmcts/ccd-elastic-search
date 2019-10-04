variable "product" {
  type    = "string"
}

variable "raw_product" {
  default = "ccd" // jenkins-library overrides product for PRs and adds e.g. pr-118-ccd
}

variable "location" {
  type    = "string"
  default = "UK South"
}

variable "env" {
  type = "string"
}

variable "subscription" {
  type = "string"
}

variable "capacity" {
  default = "1"
}

variable "common_tags" {
  type = "map"
}

variable "dataNodesAreMasterEligible" {
  type = "string"
  default = "Yes"
}

variable "vmDataNodeCount" {
  description = "number of data nodes"
  type = "string"
  default = "1"
}

variable "vmSizeAllNodes" {
  description = "vm size for all the cluster nodes"
  type = "string"
  default = "Standard_D2_v2"
}

variable "storageAccountType" {
  description = "disk storage account type"
  type = "string"
  default = "Standard"
}

variable "vmDataDiskCount" {
  description = "number of data node's disks"
  type = "string"
  default = "1"
}

variable "esAdditionalYaml" {
  description = "Additional configuration for Elasticsearch yaml configuration file. Each line must be separated by a \n"
  type = "string"
  default = "action.auto_create_index: .security*,.monitoring*,.watches,.triggered_watches,.watcher-history*,.logstash_dead_letter,.ml*\nxpack.monitoring.collection.enabled: true\nscript.allowed_types: inline\nscript.allowed_contexts: template, ingest\n"
}

variable "kibanaAdditionalYaml" {
  description = "Additional configuration for Kibana yaml configuration file. Each line must be separated by a \n"
  type = "string"
  default = "console.enabled: false\n"
}

variable "mgmt_subscription_id" {}
