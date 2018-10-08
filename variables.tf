variable "product" {
  type    = "string"
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