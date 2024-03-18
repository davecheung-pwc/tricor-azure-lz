variable "avd_rdsh_count" {
  default = 2
}

variable "vm_domain_name" {
  type    = string
  default = "tricor-dom.intra"
}

variable "vm_domain_oupath" {
  type    = string
  default = "CN=Computers,DC=tricor-dom,DC=intra"
}

variable "vm_domainjoin_username" {
  type    = string
  default = "avd-domainjoin"
}

variable "vm_domainjoin_password" {
  type    = string
  default = ""
}

variable "vm_localadmin_username" {
  type    = string
  default = "avd-localadmin"
}

variable "vm_localadmin_password" {
  type    = string
  default = ""
}

variable "nsg_management_subnet_address_prefixes" {
  type        = list(string)
  description = "Array containing the IPv4 address space for the management subnet. Default is [\"172.30.151.0/24\",\"10.52.31.192/27\"]."
  default     = ["172.30.151.0/24", "10.52.31.192/27"]
}