resource "azurerm_resource_group" "rg-go-eas-np-net-01" {
  provider = azurerm.landingzone_go_np
  name     = "rg-go-eas-np-net-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Landing Zone VNet"
    ApplicationId       = "net"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "NON-PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-np-appgw-01" {
  provider = azurerm.landingzone_go_np
  name     = "rg-go-eas-np-appgw-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Application Gateway"
    ApplicationId       = "appgw"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "NON-PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}
