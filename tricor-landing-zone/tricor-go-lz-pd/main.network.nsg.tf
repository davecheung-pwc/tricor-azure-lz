############################################
#region NSG - GO LZ - PD - EAS
############################################

module "nsg-go-pd-eas-appgw" {
  source = "../../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-eas-pd-appgw-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-appgw-01.location
  tags                = {}
  subnet              = azurerm_subnet.lzsubnet-go-pd-eas-appgw

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-eas-pd-appgw-01,
    azurerm_subnet.lzsubnet-go-pd-eas-appgw
  ]
}

resource "azurerm_network_security_rule" "nsg-go-pd-eas-appgw-azure-infra-v1" {
  provider                    = azurerm.landingzone_go_pd
  name                        = "iba-appgw-gatewaymanager-v1"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "65503-65534"
  source_address_prefix       = "*" # Instead of using GatewayManager tag, use Internet to avoid error in association
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-go-pd-eas-appgw.nsg.resource_group_name
  network_security_group_name = module.nsg-go-pd-eas-appgw.nsg.name
}

resource "azurerm_network_security_rule" "nsg-go-pd-eas-appgw-azure-infra-v2" {
  provider                    = azurerm.landingzone_go_pd
  name                        = "iba-appgw-gatewaymanager-v2"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  source_address_prefix       = "*" # Instead of using GatewayManager tag, use Internet to avoid error in association
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-go-pd-eas-appgw.nsg.resource_group_name
  network_security_group_name = module.nsg-go-pd-eas-appgw.nsg.name
}

resource "azurerm_network_security_rule" "nsg-go-pd-eas-appgw-allow-cloudflare-ipv4" {
  provider               = azurerm.landingzone_go_pd
  name                   = "iba-appgw-cloudflare-ipv4"
  priority               = 1003
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "*"
  source_port_range      = "*"
  destination_port_range = "*"
  source_address_prefixes = [
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
    "104.16.0.0/13",
    "104.24.0.0/14",
    "172.64.0.0/13",
    "131.0.72.0/22"
  ]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-go-pd-eas-appgw.nsg.resource_group_name
  network_security_group_name = module.nsg-go-pd-eas-appgw.nsg.name
}

resource "azurerm_network_security_rule" "nsg-go-pd-eas-appgw-allow-cloudflare-ipv6" {
  provider               = azurerm.landingzone_go_pd
  name                   = "iba-appgw-cloudflare-ipv6"
  priority               = 1004
  direction              = "Inbound"
  access                 = "Allow"
  protocol               = "*"
  source_port_range      = "*"
  destination_port_range = "*"
  source_address_prefixes = [
    "2400:cb00::/32",
    "2606:4700::/32",
    "2803:f800::/32",
    "2405:b500::/32",
    "2405:8100::/32",
    "2a06:98c0::/29",
    "2c0f:f248::/32"
  ]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-go-pd-eas-appgw.nsg.resource_group_name
  network_security_group_name = module.nsg-go-pd-eas-appgw.nsg.name
}

############################################
#endregion NSG - GO LZ - PD - EAS
############################################
