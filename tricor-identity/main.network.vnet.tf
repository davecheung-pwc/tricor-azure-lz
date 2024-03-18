############################################
#region Virtual Network - Identity - EAS
############################################

resource "azurerm_virtual_network" "identityvnet-eas" {
  provider            = azurerm.identity
  name                = "vnet-go-eas-pd-idnet-01"
  location            = azurerm_resource_group.rg-go-eas-pd-idnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-idnet-01.name
  address_space       = ["10.55.224.0/24"]
  dns_servers         = ["10.55.224.4", "10.55.224.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "identitysubnet-eas-addc" {
  provider             = azurerm.identity
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-idnet-01.name
  virtual_network_name = azurerm_virtual_network.identityvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.identityvnet-eas.name, "snet-addc-01")
  address_prefixes     = ["10.55.224.0/28"]
}

############################################
#endregion Virtual Network - Identity - EAS
############################################

############################################
#region Virtual Network - Identity - SEA
############################################

resource "azurerm_virtual_network" "identityvnet-sea" {
  provider            = azurerm.identity
  name                = "vnet-go-sea-pd-idnet-01"
  location            = azurerm_resource_group.rg-go-sea-pd-idnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-sea-pd-idnet-01.name
  address_space       = ["10.55.225.0/24"]
  dns_servers         = ["10.55.225.4", "10.55.225.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "identitysubnet-sea-addc" {
  provider             = azurerm.identity
  resource_group_name  = azurerm_resource_group.rg-go-sea-pd-idnet-01.name
  virtual_network_name = azurerm_virtual_network.identityvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.identityvnet-sea.name, "snet-addc-01")
  address_prefixes     = ["10.55.225.0/28"]
}

############################################
#endregion Virtual Network - Identity - SEA
############################################

############################################
#region Virtual Network - Identity - JPE
############################################

resource "azurerm_virtual_network" "identityvnet-jpe" {
  provider            = azurerm.identity
  name                = "vnet-go-jpe-pd-idnet-01"
  location            = azurerm_resource_group.rg-go-jpe-pd-idnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpe-pd-idnet-01.name
  address_space       = ["10.55.226.0/24"]
  dns_servers         = ["10.55.226.4", "10.55.226.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "identitysubnet-jpe-addc" {
  provider             = azurerm.identity
  resource_group_name  = azurerm_resource_group.rg-go-jpe-pd-idnet-01.name
  virtual_network_name = azurerm_virtual_network.identityvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.identityvnet-jpe.name, "snet-addc-01")
  address_prefixes     = ["10.55.226.0/28"]
}

############################################
#endregion Virtual Network - Identity - JPE
############################################

############################################
#region Virtual Network - Identity - JPW
############################################

resource "azurerm_virtual_network" "identityvnet-jpw" {
  provider            = azurerm.identity
  name                = "vnet-go-jpw-pd-idnet-01"
  location            = azurerm_resource_group.rg-go-jpw-pd-idnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpw-pd-idnet-01.name
  address_space       = ["10.55.227.0/24"]
  dns_servers         = ["10.55.227.4", "10.55.227.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "identitysubnet-jpw-addc" {
  provider             = azurerm.identity
  resource_group_name  = azurerm_resource_group.rg-go-jpw-pd-idnet-01.name
  virtual_network_name = azurerm_virtual_network.identityvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.identityvnet-jpw.name, "snet-addc-01")
  address_prefixes     = ["10.55.227.0/28"]
}

############################################
#endregion Virtual Network - Identity - JPW
############################################


############################################
#region Virtual Hub <-> Virtual Network Connection
############################################

resource "azurerm_virtual_hub_connection" "identityvhubconnection-eas" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-eas-name, azurerm_virtual_network.identityvnet-eas.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-eas-id
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-eas.id
}

resource "azurerm_virtual_hub_connection" "identityvhubconnection-sea" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-sea-name, azurerm_virtual_network.identityvnet-sea.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-sea-id
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-sea.id
}

resource "azurerm_virtual_hub_connection" "identityvhubconnection-jpe" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-jpe-name, azurerm_virtual_network.identityvnet-jpe.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-jpe-id
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-jpe.id
}

resource "azurerm_virtual_hub_connection" "identityvhubconnection-jpw" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-jpw-name, azurerm_virtual_network.identityvnet-jpw.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-jpw-id
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-jpw.id
}

############################################
#endregion Virtual Hub <-> Virtual Network Connection
############################################


############################################
#region Virtual Network Peering
############################################

resource "azurerm_virtual_network_peering" "identityvnet-to-connectivityvnet-eas" {
  provider                  = azurerm.identity
  name                      = format("%s-to-%s", azurerm_virtual_network.identityvnet-eas.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name)
  resource_group_name       = azurerm_virtual_network.identityvnet-eas.resource_group_name
  virtual_network_name      = azurerm_virtual_network.identityvnet-eas.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-identityvnet-eas" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name, azurerm_virtual_network.identityvnet-eas.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-eas-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-eas.id
}

resource "azurerm_virtual_network_peering" "identityvnet-to-connectivityvnet-sea" {
  provider                  = azurerm.identity
  name                      = format("%s-to-%s", azurerm_virtual_network.identityvnet-sea.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-sea-name)
  resource_group_name       = azurerm_virtual_network.identityvnet-sea.resource_group_name
  virtual_network_name      = azurerm_virtual_network.identityvnet-sea.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-sea-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-identityvnet-sea" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-sea-name, azurerm_virtual_network.identityvnet-sea.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-sea-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-sea-name
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-sea.id
}

resource "azurerm_virtual_network_peering" "identityvnet-to-connectivityvnet-jpe" {
  provider                  = azurerm.identity
  name                      = format("%s-to-%s", azurerm_virtual_network.identityvnet-jpe.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpe-name)
  resource_group_name       = azurerm_virtual_network.identityvnet-jpe.resource_group_name
  virtual_network_name      = azurerm_virtual_network.identityvnet-jpe.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpe-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-identityvnet-jpe" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpe-name, azurerm_virtual_network.identityvnet-jpe.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-jpe-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpe-name
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-jpe.id
}

resource "azurerm_virtual_network_peering" "identityvnet-to-connectivityvnet-jpw" {
  provider                  = azurerm.identity
  name                      = format("%s-to-%s", azurerm_virtual_network.identityvnet-jpw.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpw-name)
  resource_group_name       = azurerm_virtual_network.identityvnet-jpw.resource_group_name
  virtual_network_name      = azurerm_virtual_network.identityvnet-jpw.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpw-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-identityvnet-jpw" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpw-name, azurerm_virtual_network.identityvnet-jpw.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-jpw-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-jpw-name
  remote_virtual_network_id = azurerm_virtual_network.identityvnet-jpw.id
}

############################################
#endregion Virtual Network Peering
############################################
