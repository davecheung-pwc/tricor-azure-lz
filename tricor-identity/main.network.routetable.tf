############################################
#region Route Table - Identity - EAS
############################################

resource "azurerm_route_table" "identityrt-eas" {
  provider            = azurerm.identity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.identityvnet-eas.name, "default")
  location            = azurerm_virtual_network.identityvnet-eas.location
  resource_group_name = azurerm_virtual_network.identityvnet-eas.resource_group_name

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

resource "azurerm_subnet_route_table_association" "identityrt-eas_association_identitysubnet-eas-addc" {
  provider       = azurerm.identity
  subnet_id      = azurerm_subnet.identitysubnet-eas-addc.id
  route_table_id = azurerm_route_table.identityrt-eas.id
}

############################################
#endregion Route Table - Identity - EAS
############################################

############################################
#region Route Table - Identity - SEA
############################################

resource "azurerm_route_table" "identityrt-sea" {
  provider            = azurerm.identity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.identityvnet-sea.name, "default")
  location            = azurerm_virtual_network.identityvnet-sea.location
  resource_group_name = azurerm_virtual_network.identityvnet-sea.resource_group_name

  # route {
  #   name                   = "rt-0.0.0.0-internet"
  #   address_prefix         = "0.0.0.0/0"
  #   next_hop_type          = "VirtualAppliance"
  #   next_hop_in_ip_address = "10.55.192.36"
  # }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "identityrt-sea_association_identitysubnet-sea-addc" {
  provider       = azurerm.identity
  subnet_id      = azurerm_subnet.identitysubnet-sea-addc.id
  route_table_id = azurerm_route_table.identityrt-sea.id
}

############################################
#endregion Route Table - Identity - SEA
############################################

############################################
#region Route Table - Identity - JPE
############################################

resource "azurerm_route_table" "identityrt-jpe" {
  provider            = azurerm.identity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.identityvnet-jpe.name, "default")
  location            = azurerm_virtual_network.identityvnet-jpe.location
  resource_group_name = azurerm_virtual_network.identityvnet-jpe.resource_group_name

  # route {
  #   name                   = "rt-0.0.0.0-internet"
  #   address_prefix         = "0.0.0.0/0"
  #   next_hop_type          = "VirtualAppliance"
  #   next_hop_in_ip_address = "10.55.192.36"
  # }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "identityrt-jpe_association_identitysubnet-jpe-addc" {
  provider       = azurerm.identity
  subnet_id      = azurerm_subnet.identitysubnet-jpe-addc.id
  route_table_id = azurerm_route_table.identityrt-jpe.id
}

############################################
#endregion Route Table - Identity - JPE
############################################

############################################
#region Route Table - Identity - JPW
############################################

resource "azurerm_route_table" "identityrt-jpw" {
  provider            = azurerm.identity
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.identityvnet-jpw.name, "default")
  location            = azurerm_virtual_network.identityvnet-jpw.location
  resource_group_name = azurerm_virtual_network.identityvnet-jpw.resource_group_name

  # route {
  #   name                   = "rt-0.0.0.0-internet"
  #   address_prefix         = "0.0.0.0/0"
  #   next_hop_type          = "VirtualAppliance"
  #   next_hop_in_ip_address = "10.55.192.36"
  # }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_route_table_association" "identityrt-jpw_association_identitysubnet-jpw-addc" {
  provider       = azurerm.identity
  subnet_id      = azurerm_subnet.identitysubnet-jpw-addc.id
  route_table_id = azurerm_route_table.identityrt-jpw.id
}

############################################
#endregion Route Table - Identity - JPW
############################################
