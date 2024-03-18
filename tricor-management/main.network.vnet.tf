############################################
#region Virtual Network - Management - EAS
############################################

resource "azurerm_virtual_network" "managementvnet-eas" {
  provider            = azurerm.management
  name                = "vnet-go-eas-pd-mgmtnet-01"
  location            = azurerm_resource_group.rg-go-eas-pd-mgmtnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-mgmtnet-01.name
  address_space       = ["10.55.160.0/24"]
  dns_servers         = []

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "managementsubnet-eas-veeam" {
  provider             = azurerm.management
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-mgmtnet-01.name
  virtual_network_name = azurerm_virtual_network.managementvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.managementvnet-eas.name, "snet-veeam-01")
  address_prefixes     = ["10.55.160.0/28"]
  service_endpoints    = ["Microsoft.ServiceBus", "Microsoft.Storage"]
}

resource "azurerm_subnet" "managementsubnet-eas-vmimg" {
  provider             = azurerm.management
  resource_group_name  = azurerm_resource_group.rg-go-eas-pd-mgmtnet-01.name
  virtual_network_name = azurerm_virtual_network.managementvnet-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.managementvnet-eas.name, "snet-vmimg-01")
  address_prefixes     = ["10.55.160.16/28"]
}

#endregion Virtual Network - Management - EAS
############################################

############################################
#region Virtual Network - Management - SEA
############################################

resource "azurerm_virtual_network" "managementvnet-sea" {
  provider            = azurerm.management
  name                = "vnet-go-sea-pd-mgmtnet-01"
  location            = azurerm_resource_group.rg-go-sea-pd-mgmtnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-sea-pd-mgmtnet-01.name
  address_space       = ["10.55.161.0/24"]
  dns_servers         = ["10.55.225.4", "10.55.225.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "managementsubnet-sea-veeam" {
  provider             = azurerm.management
  resource_group_name  = azurerm_resource_group.rg-go-sea-pd-mgmtnet-01.name
  virtual_network_name = azurerm_virtual_network.managementvnet-sea.name
  name                 = format("%s-%s", azurerm_virtual_network.managementvnet-sea.name, "snet-veeam-01")
  address_prefixes     = ["10.55.161.0/28"]
}

#endregion Virtual Network - Management - SEA
############################################

############################################
#region Virtual Network - Management - JPE
############################################

resource "azurerm_virtual_network" "managementvnet-jpe" {
  provider            = azurerm.management
  name                = "vnet-go-jpe-pd-mgmtnet-01"
  location            = azurerm_resource_group.rg-go-jpe-pd-mgmtnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpe-pd-mgmtnet-01.name
  address_space       = ["10.55.162.0/24"]
  dns_servers         = ["10.55.226.4", "10.55.226.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "managementsubnet-jpe-veeam" {
  provider             = azurerm.management
  resource_group_name  = azurerm_resource_group.rg-go-jpe-pd-mgmtnet-01.name
  virtual_network_name = azurerm_virtual_network.managementvnet-jpe.name
  name                 = format("%s-%s", azurerm_virtual_network.managementvnet-jpe.name, "snet-veeam-01")
  address_prefixes     = ["10.55.162.0/28"]
}

#endregion Virtual Network - Management - JPE
############################################

############################################
#region Virtual Network - Management - JPW
############################################

resource "azurerm_virtual_network" "managementvnet-jpw" {
  provider            = azurerm.management
  name                = "vnet-go-jpw-pd-mgmtnet-01"
  location            = azurerm_resource_group.rg-go-jpw-pd-mgmtnet-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpw-pd-mgmtnet-01.name
  address_space       = ["10.55.163.0/24"]
  dns_servers         = ["10.55.227.4", "10.55.227.5"]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "managementsubnet-jpw-veeam" {
  provider             = azurerm.management
  resource_group_name  = azurerm_resource_group.rg-go-jpw-pd-mgmtnet-01.name
  virtual_network_name = azurerm_virtual_network.managementvnet-jpw.name
  name                 = format("%s-%s", azurerm_virtual_network.managementvnet-jpw.name, "snet-veeam-01")
  address_prefixes     = ["10.55.163.0/28"]
}

#endregion Virtual Network - Management - JPW
############################################


############################################
#region Virtual Hub <-> Virtual Network Connection
############################################

resource "azurerm_virtual_hub_connection" "managementvhubconnection-eas" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-eas-name, azurerm_virtual_network.managementvnet-eas.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-eas-id
  remote_virtual_network_id = azurerm_virtual_network.managementvnet-eas.id
}

resource "azurerm_virtual_hub_connection" "managementvhubconnection-sea" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-sea-name, azurerm_virtual_network.managementvnet-sea.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-sea-id
  remote_virtual_network_id = azurerm_virtual_network.managementvnet-sea.id
}

resource "azurerm_virtual_hub_connection" "managementvhubconnection-jpe" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-jpe-name, azurerm_virtual_network.managementvnet-jpe.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-jpe-id
  remote_virtual_network_id = azurerm_virtual_network.managementvnet-jpe.id
}

resource "azurerm_virtual_hub_connection" "managementvhubconnection-jpw" {
  provider                  = azurerm.connectivity
  name                      = format("%s-%s-%s", "con", data.terraform_remote_state.connectivity.outputs.vhub-jpw-name, azurerm_virtual_network.managementvnet-jpw.name)
  virtual_hub_id            = data.terraform_remote_state.connectivity.outputs.vhub-jpw-id
  remote_virtual_network_id = azurerm_virtual_network.managementvnet-jpw.id
}

#endregion Virtual Hub <-> Virtual Network Connection
############################################


############################################
#region Virtual Network Peering
############################################

resource "azurerm_virtual_network_peering" "managementvnet-to-connectivityvnet-eas" {
  provider                  = azurerm.management
  name                      = format("%s-to-%s", azurerm_virtual_network.managementvnet-eas.name, data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name)
  resource_group_name       = azurerm_virtual_network.managementvnet-eas.resource_group_name
  virtual_network_name      = azurerm_virtual_network.managementvnet-eas.name
  remote_virtual_network_id = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-id
}

resource "azurerm_virtual_network_peering" "connectivityvnet-to-managementvnet-eas" {
  provider                  = azurerm.connectivity
  name                      = format("%s-to-%s", data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name, azurerm_virtual_network.managementvnet-eas.name)
  resource_group_name       = data.terraform_remote_state.connectivity.outputs.rg-connnet-eas-name
  virtual_network_name      = data.terraform_remote_state.connectivity.outputs.vnet-connnet-eas-name
  remote_virtual_network_id = azurerm_virtual_network.managementvnet-eas.id
}

#endregion Virtual Network Peering
############################################
