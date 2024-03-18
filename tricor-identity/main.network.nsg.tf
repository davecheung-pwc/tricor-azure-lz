############################################
#region NSG - Identity - EAS
############################################

module "nsg-eas-addc" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.identityvnet-eas.resource_group_name
  location            = azurerm_virtual_network.identityvnet-eas.location
  tags                = {}
  subnet              = azurerm_subnet.identitysubnet-eas-addc

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.identitysubnet-eas-addc
  ]
}

resource "azurerm_network_security_rule" "nsg-eas-addc-allow-adsync-onprem" {
  provider                     = azurerm.identity
  name                         = "iba-addc-adsync-onprem"
  priority                     = 501
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = ["172.17.5.22", "172.30.111.2", "172.17.5.21"]
  destination_address_prefixes = ["10.55.224.4/32", "10.55.224.5/32"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-addc-allow-adsync-azure" {
  provider                     = azurerm.identity
  name                         = "iba-addc-adsync-azure"
  priority                     = 502
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefixes      = ["10.55.224.4/32", "10.55.224.5/32"]
  destination_address_prefixes = ["10.55.224.4/32", "10.55.224.5/32"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-addc-allow-domainjoin-tcp" {
  provider                     = azurerm.identity
  name                         = "iba-addc-domainjoin-tcp"
  priority                     = 503
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_ranges      = ["88", "135", "139", "389", "445", "49152-65535"]
  source_address_prefix        = "VirtualNetwork"
  destination_address_prefixes = ["10.55.224.4/32", "10.55.224.5/32"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-addc-allow-domainjoin-udp" {
  provider                     = azurerm.identity
  name                         = "iba-addc-domainjoin-udp"
  priority                     = 504
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Udp"
  source_port_range            = "*"
  destination_port_ranges      = ["53", "389"]
  source_address_prefix        = "VirtualNetwork"
  destination_address_prefixes = ["10.55.224.4/32", "10.55.224.5/32"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-addc-allow-dns" {
  provider                     = azurerm.identity
  name                         = "iba-addc-dns"
  priority                     = 1001
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_ranges      = ["53"]
  source_address_prefix        = "VirtualNetwork"
  destination_address_prefixes = ["10.55.224.4/32", "10.55.224.5/32"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "identitynsg-eas-addc-temp-outbound-allow-private" {
  provider                     = azurerm.identity
  name                         = "oba-temp-private"
  priority                     = 200
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "*"
  source_port_range            = "*"
  destination_port_range       = "*"
  source_address_prefix        = "*"
  destination_address_prefixes = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  resource_group_name          = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name  = module.nsg-eas-addc.nsg.name
}

resource "azurerm_network_security_rule" "identitynsg-eas-addc-temp-outbound-deny-internet" {
  provider                    = azurerm.identity
  name                        = "obd-temp-internet"
  priority                    = 400
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-addc.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-addc.nsg.name
}

#endregion NSG - Identity - EAS
############################################

############################################
#region NSG - Identity - SEA
############################################

module "nsg-sea-addc" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.identityvnet-sea.resource_group_name
  location            = azurerm_virtual_network.identityvnet-sea.location
  tags                = {}
  subnet              = azurerm_subnet.identitysubnet-sea-addc

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.identitysubnet-sea-addc
  ]
}

#endregion NSG - Identity - SEA
############################################

############################################
#region NSG - Identity - JPE
############################################

module "nsg-jpe-addc" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.identityvnet-jpe.resource_group_name
  location            = azurerm_virtual_network.identityvnet-jpe.location
  tags                = {}
  subnet              = azurerm_subnet.identitysubnet-jpe-addc

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.identitysubnet-jpe-addc
  ]
}

#endregion NSG - Identity - JPE
############################################

############################################
#region NSG - Identity - JPW
############################################

module "nsg-jpw-addc" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.identityvnet-jpw.resource_group_name
  location            = azurerm_virtual_network.identityvnet-jpw.location
  tags                = {}
  subnet              = azurerm_subnet.identitysubnet-jpw-addc

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.identitysubnet-jpw-addc
  ]
}

#endregion NSG - Identity - JPW
############################################
