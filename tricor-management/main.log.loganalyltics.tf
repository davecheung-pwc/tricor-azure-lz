resource "azurerm_log_analytics_workspace" "log-eas" {
  provider            = azurerm.management
  name                = "log-go-eas-pd-log-01"
  location            = azurerm_resource_group.rg-go-eas-pd-log-01.location
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-log-01.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_log_analytics_workspace" "log-sea" {
  provider            = azurerm.management
  name                = "log-go-sea-pd-log-01"
  location            = azurerm_resource_group.rg-go-sea-pd-log-01.location
  resource_group_name = azurerm_resource_group.rg-go-sea-pd-log-01.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_log_analytics_workspace" "log-jpe" {
  provider            = azurerm.management
  name                = "log-go-jpe-pd-log-01"
  location            = azurerm_resource_group.rg-go-jpe-pd-log-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpe-pd-log-01.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_log_analytics_workspace" "log-jpw" {
  provider            = azurerm.management
  name                = "log-go-jpw-pd-log-01"
  location            = azurerm_resource_group.rg-go-jpw-pd-log-01.location
  resource_group_name = azurerm_resource_group.rg-go-jpw-pd-log-01.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}