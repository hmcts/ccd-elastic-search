variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the load balancer"
  type        = string
}

variable "ip_address" {
  description = "Private IP address for the load balancer"
  type        = string
}

variable "frontend_name" {
  description = "Frontend IP configuration name"
  type        = string
  default     = "LBFE"
}

variable "backend_name" {
  description = "Backend address pool name"
  type        = string
  default     = "LBBE"
}

variable "vms" {
  description = "Map of VMs to add to the backend pool"
  type = map(object({
    ip = string
  }))
}

variable "virtual_network_id" {
  description = "Virtual network ID for backend addresses"
  type        = string
}

variable "ports" {
  description = "Map of ports for probes and rules"
  type = map(object({
    name       = string
    port       = number
    probe_name = string
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "expires_after" {
  description = "Expiration tag for sandbox environments"
  type        = string
  default     = null
}
