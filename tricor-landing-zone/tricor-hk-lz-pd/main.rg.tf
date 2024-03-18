resource "azurerm_resource_group" "rg-hk-eas-pd-net-01" {
  provider = azurerm.landingzone_hk_pd
  name     = "rg-hk-eas-pd-net-01"
  location = "East Asia"
}
resource "azurerm_resource_group" "rg-hk-eas-pd-appgw-01" {
  provider = azurerm.landingzone_hk_pd
  name     = "rg-hk-eas-pd-appgw-01"
  location = "East Asia"
}

resource "azurerm_resource_group" "rg-hk-eas-pd-avd-01" {
  provider = azurerm.landingzone_hk_pd
  name     = "rg-hk-eas-pd-avd-01"
  location = "East Asia"
}