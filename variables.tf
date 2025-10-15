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

variable "enable_demo_int_deployment" {
  description = "Boolean flag to enable demo-int infrastructure deployment"
  type        = bool
  default     = false
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
# variable "subscription_id" {}

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

variable "vms_demo_int" {
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
  description = "VM configuration for demo-int env"
}

variable "enable_demo_int" {
  description = "Enable demo-int flag"
  type        = bool
  default     = false
}

variable "demo_int_rg_name" {
  description = "Demo-int RG"
  type        = string
  default     = "demo-int"
}

variable "demo_int_vnet_name" {
  description = "VNet demo-int env"
  type        = string
  default     = "core-infra-vnet-demo"
}

variable "demo_int_subnet_name" {
  description = "Subnet demo-int env"
  type        = string
  default     = "elasticsearch"
}

variable "demo_int_vnet_resource_group" {
  description = "RG demo-int env placed"
  type        = string
  default     = "core-infra-demo"
}

variable "lb_private_ip_address" {
  description = "The private IP address for the load balancer."
  type        = string
}

variable "lb_private_ip_address_demo_int" {
  description = "The private IP address for the demo-int load balancer."
  type        = string
  default     = null
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



#### NEW ####
variable "vm_admin_name" {
  description = "The admin username for the VMs."
  type        = string
  default     = "elkadmin"
}

variable "vm_publisher_name" {
  type    = string
  default = "Canonical"
}

variable "vm_offer" {
  type    = string
  default = "0001-com-ubuntu-server-focal"
}

variable "vm_sku" {
  type    = string
  default = "20_04-lts"
}

variable "vm_version" {
  type    = string
  default = "latest"
}

variable "vm_size" {
  type    = string
  default = "Standard_D4s_v3"
}

variable "enable_availability_set" {
  description = "Enable availability set for VMs"
  type        = bool
  default     = true
}

variable "availability_set_name" {
  description = "Name of the availability set"
  type        = string
  default     = ""
}

variable "availability_set_name_demo_int" {
  description = "Name of the availability set for demo-int environment"
  type        = string
  default     = ""
}

variable "platform_update_domain_count" {
  description = "Number of update domains for the availability set"
  type        = number
  default     = 20
}
variable "ipconfig_name" {
  type        = string
  description = "The name of the IPConfig to asssoicate with the NIC."
  default     = null
}
