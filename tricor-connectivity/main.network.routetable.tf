############################################
#region Route Table - VHUB - EAS
############################################

data "azurerm_virtual_hub_route_table" "rt-vhub-eas-default" {
  provider            = azurerm.connectivity
  name                = "defaultRouteTable"
  resource_group_name = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.resource_group_name
  virtual_hub_name    = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.name

  depends_on = [
    azurerm_virtual_hub.vhub-go-eas-pd-conn-01
  ]
}

############################################
#endregion Route Table - VHUB - EAS
############################################

############################################
#region Route Table - VHUB - SEA
############################################

data "azurerm_virtual_hub_route_table" "rt-vhub-sea-default" {
  provider            = azurerm.connectivity
  name                = "defaultRouteTable"
  resource_group_name = azurerm_virtual_hub.vhub-go-sea-pd-conn-01.resource_group_name
  virtual_hub_name    = azurerm_virtual_hub.vhub-go-sea-pd-conn-01.name

  depends_on = [
    azurerm_virtual_hub.vhub-go-sea-pd-conn-01
  ]
}

############################################
#endregion Route Table - VHUB - SEA
############################################

############################################
#region Route Table - VHUB - JPE
############################################

data "azurerm_virtual_hub_route_table" "rt-vhub-jpe-default" {
  provider            = azurerm.connectivity
  name                = "defaultRouteTable"
  resource_group_name = azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.resource_group_name
  virtual_hub_name    = azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.name

  depends_on = [
    azurerm_virtual_hub.vhub-go-jpe-pd-conn-01
  ]
}

############################################
#endregion Route Table - VHUB - JPE
############################################

############################################
#region Route Table - VHUB - JPW
############################################

data "azurerm_virtual_hub_route_table" "rt-vhub-jpw-default" {
  provider            = azurerm.connectivity
  name                = "defaultRouteTable"
  resource_group_name = azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.resource_group_name
  virtual_hub_name    = azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.name

  depends_on = [
    azurerm_virtual_hub.vhub-go-jpw-pd-conn-01
  ]
}

############################################
#endregion Route Table - VHUB - JPW
############################################

############################################
#region Route Table - Connectivity VNet - EAS
############################################

resource "azurerm_route_table" "connnet-eas-default" {
  provider            = azurerm.connectivity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.connectivityvnet-eas.name, "default")
  location            = azurerm_virtual_network.connectivityvnet-eas.location
  resource_group_name = azurerm_virtual_network.connectivityvnet-eas.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "connnet-eas_association_fw-ext" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-eas-fw-ext.id
  route_table_id = azurerm_route_table.connnet-eas-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-eas_association_fw-int" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-eas-fw-int.id
  route_table_id = azurerm_route_table.connnet-eas-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-eas_association_fw-mgmt" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-eas-fw-mgmt.id
  route_table_id = azurerm_route_table.connnet-eas-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-eas_association_fw-ha" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-eas-fw-ha.id
  route_table_id = azurerm_route_table.connnet-eas-default.id
}

############################################
#endregion Route Table - Connectivity VNet - EAS
############################################

############################################
#region Route Table - Connectivity VNet - SEA
############################################

resource "azurerm_route_table" "connnet-sea-default" {
  provider            = azurerm.connectivity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.connectivityvnet-sea.name, "default")
  location            = azurerm_virtual_network.connectivityvnet-sea.location
  resource_group_name = azurerm_virtual_network.connectivityvnet-sea.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "connnet-sea_association_fw-ext" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-sea-fw-ext.id
  route_table_id = azurerm_route_table.connnet-sea-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-sea_association_fw-int" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-sea-fw-int.id
  route_table_id = azurerm_route_table.connnet-sea-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-sea_association_fw-mgmt" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-sea-fw-mgmt.id
  route_table_id = azurerm_route_table.connnet-sea-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-sea_association_fw-ha" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-sea-fw-ha.id
  route_table_id = azurerm_route_table.connnet-sea-default.id
}

############################################
#endregion Route Table - Connectivity VNet - SEA
############################################

############################################
#region Route Table - Connectivity VNet - JPE
############################################

resource "azurerm_route_table" "connnet-jpe-default" {
  provider            = azurerm.connectivity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.connectivityvnet-jpe.name, "default")
  location            = azurerm_virtual_network.connectivityvnet-jpe.location
  resource_group_name = azurerm_virtual_network.connectivityvnet-jpe.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "connnet-jpe_association_fw-ext" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpe-fw-ext.id
  route_table_id = azurerm_route_table.connnet-jpe-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpe_association_fw-int" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpe-fw-int.id
  route_table_id = azurerm_route_table.connnet-jpe-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpe_association_fw-mgmt" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpe-fw-mgmt.id
  route_table_id = azurerm_route_table.connnet-jpe-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpe_association_fw-ha" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpe-fw-ha.id
  route_table_id = azurerm_route_table.connnet-jpe-default.id
}

############################################
#endregion Route Table - Connectivity VNet - JPE
############################################

############################################
#region Route Table - Connectivity VNet - JPW
############################################

resource "azurerm_route_table" "connnet-jpw-default" {
  provider            = azurerm.connectivity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.connectivityvnet-jpw.name, "default")
  location            = azurerm_virtual_network.connectivityvnet-jpw.location
  resource_group_name = azurerm_virtual_network.connectivityvnet-jpw.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "connnet-jpw_association_fw-ext" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpw-fw-ext.id
  route_table_id = azurerm_route_table.connnet-jpw-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpw_association_fw-int" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpw-fw-int.id
  route_table_id = azurerm_route_table.connnet-jpw-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpw_association_fw-mgmt" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpw-fw-mgmt.id
  route_table_id = azurerm_route_table.connnet-jpw-default.id
}

resource "azurerm_subnet_route_table_association" "connnet-jpw_association_fw-ha" {
  provider       = azurerm.connectivity
  subnet_id      = azurerm_subnet.connectivitysubnet-jpw-fw-ha.id
  route_table_id = azurerm_route_table.connnet-jpw-default.id
}

############################################
#endregion Route Table - Connectivity VNet - JPW
############################################