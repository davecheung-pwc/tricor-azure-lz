############################################
#region Route Table - HK LZ - PD - EAS
############################################

resource "azurerm_route_table" "lzrt-hk-pd-eas" {
  provider            = azurerm.landingzone_hk_pd
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.lzvnet-hk-pd-eas.name, "default")
  location            = azurerm_virtual_network.lzvnet-hk-pd-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-hk-pd-eas.resource_group_name

  route {
    name                   = "rt-0.0.0.0-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.55.192.36"
  }
}

resource "azurerm_route_table" "lzrt-hk-pd-eas-appgw" {
  provider            = azurerm.landingzone_hk_pd
  name                = format("%s-%s", "rt", azurerm_subnet.lzsubnet-hk-pd-eas-appgw.name)
  location            = azurerm_virtual_network.lzvnet-hk-pd-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-hk-pd-eas.resource_group_name

  route {
    name           = "rt-0.0.0.0-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

}

resource "azurerm_subnet_route_table_association" "lzrt-hk-pd-eas_association_lzvnet-hk-pd-eas-avd" {
  provider       = azurerm.landingzone_hk_pd
  subnet_id      = azurerm_subnet.lzsubnet-hk-pd-eas-avd.id
  route_table_id = azurerm_route_table.lzrt-hk-pd-eas.id
}

resource "azurerm_subnet_route_table_association" "lzrt-hk-pd-eas_association_lzvnet-hk-pd-eas-appgw" {
  provider       = azurerm.landingzone_hk_pd
  subnet_id      = azurerm_subnet.lzsubnet-hk-pd-eas-appgw.id
  route_table_id = azurerm_route_table.lzrt-hk-pd-eas-appgw.id
}

#endregion Route Table - HK LZ - PD - EAS
############################################