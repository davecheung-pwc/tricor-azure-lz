resource "azurerm_resource_group" "rg-go-eas-pd-net-01" {
  provider = azurerm.landingzone_go_pd
  name     = "rg-go-eas-pd-net-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Landing Zone VNet"
    ApplicationId       = "net"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-appgw-01" {
  provider = azurerm.landingzone_go_pd
  name     = "rg-go-eas-pd-appgw-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Application Gateway"
    ApplicationId       = "appgw"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-avd-01" {
  provider = azurerm.landingzone_go_pd
  name     = "rg-go-eas-pd-avd-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Virtual Desktop"
    ApplicationId       = "avd"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}