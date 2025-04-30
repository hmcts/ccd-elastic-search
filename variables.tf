variable "product" {
  type = string
}

variable "raw_product" {
  default = "ccd" // jenkins-library overrides product for PRs and adds e.g. pr-118-ccd
}

variable "location" {
  type    = string
  default = "UK South"
}

variable "env" {
  type = string
}

variable "subscription" {
  type = string
}

variable "capacity" {
  default = "1"
}

variable "common_tags" {
  type = map(any)
}

variable "dataNodesAreMasterEligible" {
  type    = string
  default = "Yes"
}

variable "vmDataNodeCount" {
  description = "number of data nodes"
  type        = string
  default     = "4"
}

variable "vmSizeAllNodes" {
  description = "vm size for all the cluster nodes"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "esVersion" {
  description = "ES version"
  type        = string
  default     = "7.17.0"
}

variable "storageAccountType" {
  description = "os disk storage account type"
  type        = string
  default     = "Standard"
}

variable "dataStorageAccountType" {
  description = "data disk storage account type"
  type        = string
  default     = "Standard"
}

variable "vmDataDiskCount" {
  description = "number of data node disks"
  default     = "1"
  type        = string
}

variable "esAdditionalYaml" {
  description = "Additional configuration for Elasticsearch yaml configuration file. Each line must be separated by a \n"
  type        = string
  default     = "action.auto_create_index: .security*,.monitoring*,.kibana*,.watches,.triggered_watches,.watcher-history*,.logstash_dead_letter,.ml*\nxpack.monitoring.collection.enabled: true\nscript.allowed_types: inline\nscript.allowed_contexts: template, ingest\ningest.geoip.downloader.enabled: false\n"
}

variable "kibanaAdditionalYaml" {
  description = "Additional configuration for Kibana yaml configuration file. Each line must be separated by a \n"
  type        = string
  default     = "console.enabled: false\n"
}

variable "esHeapSize" {
  description = "The size, in megabytes, of memory to allocate on each Elasticsearch node for the JVM heap."
  type        = number
  default     = 0
}

variable "dynatrace_instance" {
  default = ""
}

variable "dynatrace_hostgroup" {
  default = ""
}

variable "mgmt_subscription_id" {}

variable "aks_subscription_id" {}

variable "vm_names" {
  type    = list(string)
  default = ["ccd-data-0", "ccd-data-1", "ccd-data-2", "ccd-data-3"]
}


variable "vms" {
  type = map(object({
    name = optional(string)
    ip   = optional(string)
    managed_disks = map(object({
      name                 = string,
      resource_group_name  = string,
      storage_account_type = optional(string, "StandardSSD_LRS"),
      disk_lun             = string
    }))
  }))
  default = {
  }
}


variable "soc_vault_name" {
  description = "The name of the SOC Key Vault."
  type        = string
  default     = null
}

variable "soc_vault_rg" {
  description = "The name of the SOC resource group."
  type        = string
  default     = null
}

variable "nsg_security_rules" {
  description = "Security rules for the network security group"
  type = map(object({
    name                                       = string,
    description                                = optional(string, null),
    priority                                   = number,
    direction                                  = string,
    access                                     = string,
    protocol                                   = string,
    source_port_range                          = string,
    destination_port_range                     = string,
    source_address_prefix                      = string,
    destination_address_prefix                 = string,
    source_application_security_group_ids      = optional(string, null),
    destination_application_security_group_ids = optional(string, null),
    destination_port_ranges                    = optional(list(string), null),
    source_address_prefixes                    = optional(list(string), null)
  }))
  default = {}
}
