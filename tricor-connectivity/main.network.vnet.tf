############################################
#region Virtual Network - Connectivity - EAS
############################################

resource "azurerm_virtual_network" "connectivityvnet-eas" {
  provider            = azurerm.connectivity
  name                = "vnet-go-eas-pd-connnet-01"
  location            = "East Asia"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  address_space       = ["10.55.192.0/24"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "connectivitysubnet-eas-fw-ext" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-fw-ext-01")
  address_prefixes     = ["10.55.192.0/27"]
}

resource "azurerm_subnet" "connectivitysubnet-eas-fw-int" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-fw-int-01")
  address_prefixes     = ["10.55.192.32/27"]
}

resource "azurerm_subnet" "connectivitysubnet-eas-fw-mgmt" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-fw-mgmt-01")
  address_prefixes     = ["10.55.192.64/28"]
}

resource "azurerm_subnet" "connectivitysubnet-eas-fw-ha" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-fw-ha-01")
  address_prefixes     = ["10.55.192.80/28"]
}

resource "azurerm_subnet" "connectivitysubnet-eas-fw-protected" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-fw-protected-01")
  address_prefixes     = ["10.55.192.96/28"]
}

resource "azurerm_subnet" "connectivitysubnet-eas-dns-in" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-eas.name, "snet-dns-in-01")
  address_prefixes     = ["10.55.192.112/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

############################################
#endregion
############################################

############################################
#region Virtual Network - Connectivity - SEA
############################################

resource "azurerm_virtual_network" "connectivityvnet-sea" {
  provider            = azurerm.connectivity
  name                = "vnet-go-sea-pd-connnet-01"
  location            = "Southeast Asia"
  resource_group_name = azurerm_resource_group.rg-go-sea-pd-connnet-01.name
  address_space       = ["10.55.193.0/24"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "connectivitysubnet-sea-fw-ext" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-fw-ext-01")
  address_prefixes     = ["10.55.193.0/27"]
}

resource "azurerm_subnet" "connectivitysubnet-sea-fw-int" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-fw-int-01")
  address_prefixes     = ["10.55.193.32/27"]
}

resource "azurerm_subnet" "connectivitysubnet-sea-fw-mgmt" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-fw-mgmt-01")
  address_prefixes     = ["10.55.193.64/28"]
}

resource "azurerm_subnet" "connectivitysubnet-sea-fw-ha" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-fw-ha-01")
  address_prefixes     = ["10.55.193.80/28"]
}

resource "azurerm_subnet" "connectivitysubnet-sea-fw-protected" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-sea-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-fw-protected-01")
  address_prefixes     = ["10.55.193.96/28"]
}

resource "azurerm_subnet" "connectivitysubnet-sea-dns-in" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-sea.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-sea.name, "snet-dns-in-01")
  address_prefixes     = ["10.55.193.112/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

############################################
#endregion Virtual Network - Connectivity - SEA
############################################

############################################
#region Virtual Network - Connectivity - JPE
############################################

resource "azurerm_virtual_network" "connectivityvnet-jpe" {
  provider            = azurerm.connectivity
  name                = "vnet-go-jpe-pd-connnet-01"
  location            = "Japan East"
  resource_group_name = azurerm_resource_group.rg-go-jpe-pd-connnet-01.name
  address_space       = ["10.55.194.0/24"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "connectivitysubnet-jpe-fw-ext" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-fw-ext-01")
  address_prefixes     = ["10.55.194.0/27"]
}

resource "azurerm_subnet" "connectivitysubnet-jpe-fw-int" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-fw-int-01")
  address_prefixes     = ["10.55.194.32/27"]
}

resource "azurerm_subnet" "connectivitysubnet-jpe-fw-mgmt" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-fw-mgmt-01")
  address_prefixes     = ["10.55.194.64/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpe-fw-ha" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-fw-ha-01")
  address_prefixes     = ["10.55.194.80/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpe-fw-protected" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-jpe-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-fw-protected-01")
  address_prefixes     = ["10.55.194.96/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpe-dns-in" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpe.name, "snet-dns-in-01")
  address_prefixes     = ["10.55.194.112/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

############################################
#endregion Virtual Network - Connectivity - JPE
############################################

############################################
#region Virtual Network - Connectivity - JPW
############################################

resource "azurerm_virtual_network" "connectivityvnet-jpw" {
  provider            = azurerm.connectivity
  name                = "vnet-go-jpw-pd-connnet-01"
  location            = "Japan West"
  resource_group_name = azurerm_resource_group.rg-go-jpw-pd-connnet-01.name
  address_space       = ["10.55.195.0/24"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "connectivitysubnet-jpw-fw-ext" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-fw-ext-01")
  address_prefixes     = ["10.55.195.0/27"]
}

resource "azurerm_subnet" "connectivitysubnet-jpw-fw-int" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-fw-int-01")
  address_prefixes     = ["10.55.195.32/27"]
}

resource "azurerm_subnet" "connectivitysubnet-jpw-fw-mgmt" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-fw-mgmt-01")
  address_prefixes     = ["10.55.195.64/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpw-fw-ha" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-fw-ha-01")
  address_prefixes     = ["10.55.195.80/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpw-fw-protected" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_resource_group.rg-go-jpw-pd-connnet-01.name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-fw-protected-01")
  address_prefixes     = ["10.55.195.96/28"]
}

resource "azurerm_subnet" "connectivitysubnet-jpw-dns-in" {
  provider             = azurerm.connectivity
  resource_group_name  = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name
  virtual_network_name = azurerm_virtual_network.connectivityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.connectivityvnet-jpw.name, "snet-dns-in-01")
  address_prefixes     = ["10.55.195.112/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

############################################
#endregion Virtual Network - Connectivity - JPW
############################################

############################################
#region Virtual Hub <-> Virtual Network Connection
############################################

resource "azurerm_virtual_hub_connection" "connectivityvhubconnection-eas" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", azurerm_virtual_hub.vhub-go-eas-pd-conn-01.name, azurerm_virtual_network.connectivityvnet-eas.name)
  virtual_hub_id            = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.id
  remote_virtual_network_id = azurerm_virtual_network.connectivityvnet-eas.id
  internet_security_enabled = true
}

resource "azurerm_virtual_hub_connection" "connectivityvhubconnection-sea" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", azurerm_virtual_hub.vhub-go-sea-pd-conn-01.name, azurerm_virtual_network.connectivityvnet-sea.name)
  virtual_hub_id            = azurerm_virtual_hub.vhub-go-sea-pd-conn-01.id
  remote_virtual_network_id = azurerm_virtual_network.connectivityvnet-sea.id
  internet_security_enabled = true
}

resource "azurerm_virtual_hub_connection" "connectivityvhubconnection-jpe" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.name, azurerm_virtual_network.connectivityvnet-jpe.name)
  virtual_hub_id            = azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.id
  remote_virtual_network_id = azurerm_virtual_network.connectivityvnet-jpe.id
  internet_security_enabled = true
}

resource "azurerm_virtual_hub_connection" "connectivityvhubconnection-jpw" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.name, azurerm_virtual_network.connectivityvnet-jpw.name)
  virtual_hub_id            = azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.id
  remote_virtual_network_id = azurerm_virtual_network.connectivityvnet-jpw.id
  internet_security_enabled = true
}

############################################
#endregion Virtual Hub <-> Virtual Network Connection
############################################