variable "nsg_management_subnet_address_prefixes" {
  type        = list(string)
  description = "Array containing the IPv4 address space for the management subnet. Default is [\"172.30.151.0/24\",\"10.52.31.192/27\"]."
  default     = ["172.30.151.0/24", "10.52.31.192/27"]
}