resource "azurerm_virtual_wan" "vwan-go-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = "vwan-go-pd-conn-01"                                 #user input
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-conn-01.name     #dropdown with previous input
  location            = azurerm_resource_group.rg-go-eas-pd-conn-01.location #reference the resource group location
  type                = "Standard"

  # Configuration 
  office365_local_breakout_category = "OptimizeAndAllow"
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#region Virtual hub - EAS
############################################

resource "azurerm_virtual_hub" "vhub-go-eas-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = "vhub-go-eas-pd-conn-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-conn-01.name
  location            = "East Asia"
  virtual_wan_id      = azurerm_virtual_wan.vwan-go-pd-conn-01.id
  address_prefix      = "10.55.240.0/24"

  timeouts {
    create = "35m"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#endregion Virtual hub - EAS
############################################

############################################
#region Virtual hub - SEA
############################################

resource "azurerm_virtual_hub" "vhub-go-sea-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = "vhub-go-sea-pd-conn-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-conn-01.name
  location            = "Southeast Asia"
  virtual_wan_id      = azurerm_virtual_wan.vwan-go-pd-conn-01.id
  address_prefix      = "10.55.241.0/24"

  timeouts {
    create = "35m"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#endregion Virtual hub - SEA
############################################

############################################
#region Virtual hub - JPE
############################################

resource "azurerm_virtual_hub" "vhub-go-jpe-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = "vhub-go-jpe-pd-conn-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-conn-01.name
  location            = "Japan East"
  virtual_wan_id      = azurerm_virtual_wan.vwan-go-pd-conn-01.id
  address_prefix      = "10.55.242.0/24"

  timeouts {
    create = "35m"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#endregion Virtual hub - JPE
############################################

############################################
#region Virtual hub - JPW
############################################

resource "azurerm_virtual_hub" "vhub-go-jpw-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = "vhub-go-jpw-pd-conn-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-conn-01.name
  location            = "Japan West"
  virtual_wan_id      = azurerm_virtual_wan.vwan-go-pd-conn-01.id
  address_prefix      = "10.55.243.0/24"

  timeouts {
    create = "35m"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#endregion Virtual hub - JPW
############################################