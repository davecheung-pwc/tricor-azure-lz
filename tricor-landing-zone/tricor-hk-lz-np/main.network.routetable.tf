############################################
#region Route Table - HK LZ - NP - EAS
############################################

resource "azurerm_route_table" "lzrt-hk-np-eas" {
  provider            = azurerm.landingzone_hk_np
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.lzvnet-hk-np-eas.name, "default")
  location            = azurerm_virtual_network.lzvnet-hk-np-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-hk-np-eas.resource_group_name

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

resource "azurerm_route_table" "lzrt-hk-np-eas-appgw" {
  provider            = azurerm.landingzone_hk_np
  name                = format("%s-%s", "rt", azurerm_subnet.lzsubnet-hk-np-eas-appgw.name)
  location            = azurerm_virtual_network.lzvnet-hk-np-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-hk-np-eas.resource_group_name

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

resource "azurerm_subnet_route_table_association" "lzrt-hk-pd-eas_association_lzvnet-hk-np-eas-appgw" {
  provider       = azurerm.landingzone_hk_np
  subnet_id      = azurerm_subnet.lzsubnet-hk-np-eas-appgw.id
  route_table_id = azurerm_route_table.lzrt-hk-np-eas-appgw.id
}

#endregion Route Table - HK LZ - NP - EAS
############################################