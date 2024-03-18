resource "azurerm_resource_group" "net" {
  provider = azurerm.landingzone_SITE_ENV # TODO: UPDATE FOR NEW SUBSCRIPTION
  name     = "rg-SITE-REGION-ENV-net-01"  # TODO: UPDATE FOR NEW SUBSCRIPTION
  location = "East Asia"                  # TODO: UPDATE FOR NEW SUBSCRIPTION
  tags = {
    Site                = "GO" # TODO: UPDATE FOR NEW SUBSCRIPTION
    BusinessUnit        = "IT"
    ApplicationName     = "Landing Zone VNet"
    ApplicationId       = "net"
    CostCenter          = "TBC" # TODO: UPDATE FOR NEW SUBSCRIPTION
    ApplicationOwner    = "TBC"
    Environment         = "NON-PROD" # TODO: UPDATE FOR NEW SUBSCRIPTION
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "appgw" {
  provider = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name     = "rg-SITE-REGION-ENV-appgw-01" # TODO: UPDATE FOR NEW SUBSCRIPTION
  location = "East Asia"                   # TODO: UPDATE FOR NEW SUBSCRIPTION
  tags = {
    Site                = "GO" # TODO: UPDATE FOR NEW SUBSCRIPTION
    BusinessUnit        = "IT"
    ApplicationName     = "Application Gateway"
    ApplicationId       = "appgw"
    CostCenter          = "TBC" # TODO: UPDATE FOR NEW SUBSCRIPTION
    ApplicationOwner    = "TBC"
    Environment         = "NON-PROD" # TODO: UPDATE FOR NEW SUBSCRIPTION
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}
