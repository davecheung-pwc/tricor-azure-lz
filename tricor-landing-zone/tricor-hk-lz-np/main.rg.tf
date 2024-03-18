resource "azurerm_resource_group" "rg-hk-eas-np-net-01" {
  provider = azurerm.landingzone_hk_np
  name     = "rg-hk-eas-np-net-01"
  location = "East Asia"
  tags = {
    Site                = "HK"
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

resource "azurerm_resource_group" "rg-hk-eas-np-appgw-01" {
  provider = azurerm.landingzone_hk_np
  name     = "rg-hk-eas-np-appgw-01"
  location = "East Asia"
  tags = {
    Site                = "HK"
    BusinessUnit        = "IT"
    ApplicationName     = "Application Gateway"
    ApplicationId       = "appgw"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "NON-PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
    SharedApps          = "ISP-SIT, ISP-UAT"
  }
}