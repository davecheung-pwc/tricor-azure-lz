############################################
#region Route Table - Management - EAS
############################################

resource "azurerm_route_table" "managementrt-eas" {
  provider            = azurerm.management
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.managementvnet-eas.name, "default")
  location            = azurerm_virtual_network.managementvnet-eas.location
  resource_group_name = azurerm_virtual_network.managementvnet-eas.resource_group_name

  route {
    name                   = "rt-0.0.0.0-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.55.192.36"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "managementrt-eas_association_veeam" {
  provider       = azurerm.management
  subnet_id      = azurerm_subnet.managementsubnet-eas-veeam.id
  route_table_id = azurerm_route_table.managementrt-eas.id
}

resource "azurerm_subnet_route_table_association" "managementrt-eas_association_vmimg" {
  provider       = azurerm.management
  subnet_id      = azurerm_subnet.managementsubnet-eas-vmimg.id
  route_table_id = azurerm_route_table.managementrt-eas.id
}

############################################
#endregion Route Table - Management - EAS
############################################

############################################
#region Route Table - Management - SEA
############################################

resource "azurerm_route_table" "managementrt-sea" {
  provider            = azurerm.management
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.managementvnet-sea.name, "default")
  location            = azurerm_virtual_network.managementvnet-sea.location
  resource_group_name = azurerm_virtual_network.managementvnet-sea.resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "managementrt-sea_association_veeam" {
  provider       = azurerm.management
  subnet_id      = azurerm_subnet.managementsubnet-sea-veeam.id
  route_table_id = azurerm_route_table.managementrt-sea.id
}

############################################
#endregion Route Table - Management - SEA
############################################

############################################
#region Route Table - Management - JPE
############################################

resource "azurerm_route_table" "managementrt-jpe" {
  provider            = azurerm.management
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.managementvnet-jpe.name, "default")
  location            = azurerm_virtual_network.managementvnet-jpe.location
  resource_group_name = azurerm_virtual_network.managementvnet-jpe.resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "managementrt-jpe_association_veeam" {
  provider       = azurerm.management
  subnet_id      = azurerm_subnet.managementsubnet-jpe-veeam.id
  route_table_id = azurerm_route_table.managementrt-jpe.id
}

############################################
#endregion Route Table - Management - JPE
############################################

############################################
#region Route Table - Management - JPW
############################################

resource "azurerm_route_table" "managementrt-jpw" {
  provider            = azurerm.management
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.managementvnet-jpw.name, "default")
  location            = azurerm_virtual_network.managementvnet-jpw.location
  resource_group_name = azurerm_virtual_network.managementvnet-jpw.resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "managementrt-jpw_association_veeam" {
  provider       = azurerm.management
  subnet_id      = azurerm_subnet.managementsubnet-jpw-veeam.id
  route_table_id = azurerm_route_table.managementrt-jpw.id
}

############################################
#endregion Route Table - Management - JPW
############################################
