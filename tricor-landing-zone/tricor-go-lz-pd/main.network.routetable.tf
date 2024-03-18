############################################
#region Route Table - GO LZ - PD - EAS
############################################

resource "azurerm_route_table" "lzrt-go-pd-eas" {
  provider            = azurerm.landingzone_go_pd
  name                = format("%s-%s-%s", "rt", azurerm_virtual_network.lzvnet-go-pd-eas.name, "default")
  location            = azurerm_virtual_network.lzvnet-go-pd-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-go-pd-eas.resource_group_name

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

resource "azurerm_route_table" "lzrt-go-pd-eas-appgw" {
  provider            = azurerm.landingzone_go_pd
  name                = format("%s-%s", "rt", azurerm_subnet.lzsubnet-go-pd-eas-appgw.name)
  location            = azurerm_virtual_network.lzvnet-go-pd-eas.location
  resource_group_name = azurerm_virtual_network.lzvnet-go-pd-eas.resource_group_name

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

resource "azurerm_subnet_route_table_association" "lzrt-go-pd-eas_association_lzvnet-go-pd-eas-appgw" {
  provider       = azurerm.landingzone_go_pd
  subnet_id      = azurerm_subnet.lzsubnet-go-pd-eas-appgw.id
  route_table_id = azurerm_route_table.lzrt-go-pd-eas-appgw.id
}

############################################
#endregion Route Table - GO LZ - PD - EAS
############################################