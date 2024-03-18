############################################
#region NSG - Connectivity - EAS
############################################

module "nsg-eas-fw-ext" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-eas.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-eas.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-eas-fw-ext

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-eas-fw-ext
  ]
}

module "nsg-eas-fw-int" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-eas.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-eas.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-eas-fw-int

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-eas-fw-int
  ]
}

module "nsg-eas-fw-mgmt" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-eas.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-eas.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-eas-fw-mgmt

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-eas-fw-mgmt
  ]
}

module "nsg-eas-fw-ha" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-eas.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-eas.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-eas-fw-ha

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-eas-fw-ha
  ]
}

resource "azurerm_network_security_rule" "nsg-eas-fw-ext-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-fw-ext-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ext"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-fw-int-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-int"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-fw-int.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-int.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-fw-ha-fortigate-allow-ha" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ha"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.nsg-eas-fw-ha.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-ha.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-fw-mgmt-fortigate-allow-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_virtual_network.connectivityvnet-eas.address_space[0]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-mgmt.nsg.name
}

resource "azurerm_network_security_rule" "nsg-eas-fw-mgmt-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-eas-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-eas-fw-mgmt.nsg.name
}

############################################
#endregion NSG - Connectivity - EAS
############################################

############################################
#region NSG - Connectivity - SEA
############################################

module "nsg-sea-fw-ext" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-sea.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-sea-fw-ext

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-sea-fw-ext
  ]
}

module "nsg-sea-fw-int" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-sea.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-sea-fw-int

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-sea-fw-int
  ]
}

module "nsg-sea-fw-mgmt" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-sea.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-sea-fw-mgmt

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-sea-fw-mgmt
  ]
}

module "nsg-sea-fw-ha" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-sea.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-sea-fw-ha

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-sea-fw-ha
  ]
}

resource "azurerm_network_security_rule" "nsg-sea-fw-ext-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-sea-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-sea-fw-ext-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ext"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-sea-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-sea-fw-int-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-int"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-sea-fw-int.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-int.nsg.name
}

resource "azurerm_network_security_rule" "nsg-sea-fw-ha-fortigate-allow-ha" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ha"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.nsg-sea-fw-ha.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-ha.nsg.name
}

resource "azurerm_network_security_rule" "nsg-sea-fw-mgmt-fortigate-allow-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_virtual_network.connectivityvnet-sea.address_space[0]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-sea-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-mgmt.nsg.name
}

resource "azurerm_network_security_rule" "nsg-sea-fw-mgmt-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-sea-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-sea-fw-mgmt.nsg.name
}

############################################
#endregion NSG - Connectivity - SEA
############################################

############################################
#region NSG - Connectivity - JPE
############################################

module "nsg-jpe-fw-ext" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpe.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpe-fw-ext

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpe-fw-ext
  ]
}

module "nsg-jpe-fw-int" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpe.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpe-fw-int

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpe-fw-int
  ]
}

module "nsg-jpe-fw-mgmt" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpe.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpe-fw-mgmt

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpe-fw-mgmt
  ]
}

module "nsg-jpe-fw-ha" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpe.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpe-fw-ha

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpe-fw-ha
  ]
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-ext-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpe-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-ext-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ext"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpe-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-int-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-int"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpe-fw-int.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-int.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-ha-fortigate-allow-ha" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ha"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.nsg-jpe-fw-ha.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-ha.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-mgmt-fortigate-allow-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_virtual_network.connectivityvnet-jpe.address_space[0]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpe-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-mgmt.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpe-fw-mgmt-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpe-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-jpe-fw-mgmt.nsg.name
}

############################################
#endregion NSG - Connectivity - JPE
############################################

############################################
#region NSG - Connectivity - JPW
############################################

module "nsg-jpw-fw-ext" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpw.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpw-fw-ext

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpw-fw-ext
  ]
}

module "nsg-jpw-fw-int" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpw.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpw-fw-int

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpw-fw-int
  ]
}

module "nsg-jpw-fw-mgmt" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpw.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpw-fw-mgmt

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpw-fw-mgmt
  ]
}

module "nsg-jpw-fw-ha" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  location            = azurerm_virtual_network.connectivityvnet-jpw.location
  tags                = {}
  subnet              = azurerm_subnet.connectivitysubnet-jpw-fw-ha

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.connectivitysubnet-jpw-fw-ha
  ]
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-ext-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpw-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-ext-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ext"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpw-fw-ext.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-ext.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-int-fortigate-allow-any" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-int"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpw-fw-int.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-int.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-ha-fortigate-allow-ha" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-ha"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = module.nsg-jpw-fw-ha.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-ha.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-mgmt-fortigate-allow-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "iba-fortigate-mgmt"
  priority                    = 501
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_virtual_network.connectivityvnet-jpw.address_space[0]
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpw-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-mgmt.nsg.name
}

resource "azurerm_network_security_rule" "nsg-jpw-fw-mgmt-fortigate-deny-mgmt" {
  provider                    = azurerm.connectivity
  name                        = "ibd-fortigate-deny-mgmt"
  priority                    = 502
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_ranges     = [22, 80, 443]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = module.nsg-jpw-fw-mgmt.nsg.resource_group_name
  network_security_group_name = module.nsg-jpw-fw-mgmt.nsg.name
}

############################################
#endregion NSG - Connectivity - JPW
############################################
