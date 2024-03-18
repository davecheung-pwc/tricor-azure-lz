############################################
#region Virtual Network - GO LZ - PD - EAS
############################################

resource "azurerm_virtual_network" "lzvnet-go-pd-eas" {
  provider            = azurerm.landingzone_go_pd
  name                = "vnet-go-eas-pd-net-01"
  location            = azurerm_resource_group.rg-go-eas-pd-net-01.location
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-net-01.name
  address_space       = ["10.52.32.0/19"]
  dns_servers         = ["10.55.224.4", "10.55.224.5"]
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "lzsubnet-go-pd-eas-appgw" {
  provider             = azurerm.landingzone_go_pd
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-net-01.name
  virtual_network_name = azurerm_virtual_network.lzvnet-go-pd-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.lzvnet-go-pd-eas.name, "snet-appgw-01")
  address_prefixes     = ["10.52.63.224/27"]
}

############################################
#endregion Virtual Network - GO LZ - PD - EAS
############################################

############################################
#region Virtual Hub <-> Virtual Network Connection
############################################

resource "azurerm_virtual_hub_connection" "lzvhubconnection" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-eas-name, azurerm_virtual_network.lzvnet-go-pd-eas.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-eas-id
  remote_virtual_network_id = azurerm_virtual_network.lzvnet-go-pd-eas.id
}

resource "azurerm_virtual_network_peering" "lzvnet-to-connectivityvnet" {
  provider                  = azurerm.landingzone_go_pd
  name                      = format("%s-to-%s", azurerm_virtual_network.lzvnet-go-pd-eas.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name)
  resource_group_name       = azurerm_resource_group.rg-go-eas-pd-net-01.name
  virtual_network_name      = azurerm_virtual_network.lzvnet-go-pd-eas.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-lzvnet" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name, azurerm_virtual_network.lzvnet-go-pd-eas.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-eas-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name
  remote_virtual_network_id = azurerm_virtual_network.lzvnet-go-pd-eas.id
}

############################################
#endregion Virtual Hub <-> Virtual Network Connection
############################################