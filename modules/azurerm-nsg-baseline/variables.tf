variable "resource_group_name" {
  type        = string
  description = "Name of an existing resource group to deply the network security group into."
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group (NSG) to create."
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure region to deploy to. Recommendation is to set to the same location as the resource group."
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "Map of key value pairs for the resource tagging. Default: none."
  default     = {}
}

variable "module_depends_on" {
  type    = any
  default = null
}

variable "subnet" {
  type    = any
}

variable "management_subnet_address_prefixes" {
  type        = list(string)
  description = "Array containing the IPv4 address space for the management subnet. Default is [\"10.0.0.0/28\"]."
  default     = ["10.0.0.0/28"]
}

variable "allow_samesubnet" {
  type = bool
  default = false
}