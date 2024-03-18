############################################
#region Route Table - SITE LZ - ENV - REGION
############################################

resource "azurerm_route_table" "rt-default" {
  provider            = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.vnet.name, "default")
  location            = azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name

  route {
    name                   = "rt-0.0.0.0-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.55.192.36" # TODO: UPDATE FOR NEW SUBSCRIPTION
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_route_table" "rt-appgw" {
  provider            = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                = format("%s-%s", "rt", azurerm_subnet.appgw.name)
  location            = azurerm_virtual_network.vnet.location
  resource_group_name = azurerm_virtual_network.vnet.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

}

resource "azurerm_subnet_route_table_association" "rt-appgw-association" {
  provider       = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  subnet_id      = azurerm_subnet.appgw.id
  route_table_id = azurerm_route_table.rt-appgw.id
}

#endregion Route Table - SITE LZ - ENV - REGION
############################################
