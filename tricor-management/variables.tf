variable "vm_image_local_admin_username" {
  type    = string
  default = "avd-localadmin"
}

variable "vm_image_local_admin_password" {
  type    = string
  default = "karhVA7c%P5+%zgV"
}

variable "eas_addc_ip_addresses" {
  default = ["10.55.224.4", "10.55.224.5"]
}

variable "nsg_management_subnet_address_prefixes" {
  type        = list(string)
  description = "Array containing the IPv4 address space for the management subnet. Default is [\"172.30.151.0/24\",\"10.52.31.192/27\"]."
  default     = ["172.30.151.0/24", "10.52.31.192/27"]
}