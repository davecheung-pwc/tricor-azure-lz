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
  default = "tricor-domainjoin"
}

variable "vm_domainjoin_password" {
  type    = string
  default = ""
}

variable "vm_localadmin_username" {
  type    = string
  default = "tricoruser"
}

variable "vm_localadmin_password" {
  type    = string
  default = ""
}