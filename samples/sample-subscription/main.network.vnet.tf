############################################
#region Virtual Network - SITE LZ - ENV - REGION
############################################

resource "azurerm_virtual_network" "vnet" {
  provider            = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                = "vnet-SITE-REGION-ENV-net-01" # TODO: UPDATE FOR NEW SUBSCRIPTION
  location            = azurerm_resource_group.net.location
  resource_group_name = azurerm_resource_group.net.name
  address_space       = ["10.52.160.0/19"]             # TODO: UPDATE FOR NEW SUBSCRIPTION
  dns_servers         = ["10.55.224.4", "10.55.224.5"] # TODO: UPDATE FOR NEW SUBSCRIPTION
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "appgw" {
  provider             = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  resource_group_name  = azurerm_resource_group.net.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = format("%s-%s", azurerm_virtual_network.vnet.name, "snet-appgw-01")
  address_prefixes     = ["10.52.191.224/27"] # TODO: UPDATE FOR NEW SUBSCRIPTION
}

#endregion Virtual Network - SITE LZ - ENV - REGION
############################################

############################################
#region Virtual Hub <-> Virtual Network Connection
############################################

resource "azurerm_virtual_hub_connection" "lzvhubconnection" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-eas-name, azurerm_virtual_network.vnet.name) # TODO: UPDATE FOR NEW SUBSCRIPTION
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-eas-id # TODO: UPDATE FOR NEW SUBSCRIPTION
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_virtual_network_peering" "lzvnet-to-connectivityvnet" {
  provider                  = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                      = format("%s-to-%s", azurerm_virtual_network.vnet.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name) # TODO: UPDATE FOR NEW SUBSCRIPTION
  resource_group_name       = azurerm_resource_group.net.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-id # TODO: UPDATE FOR NEW SUBSCRIPTION
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-lzvnet" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name, azurerm_virtual_network.vnet.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-eas-name # TODO: UPDATE FOR NEW SUBSCRIPTION
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name # TODO: UPDATE FOR NEW SUBSCRIPTION
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}

#endregion Virtual Hub <-> Virtual Network Connection
############################################
