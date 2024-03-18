
resource "azurerm_storage_account" "storageaccount-avd" {
  provider                      = azurerm.landingzone_hk_pd
  name                          = "sahkeaspdavd01"
  resource_group_name           = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  location                      = azurerm_resource_group.rg-hk-eas-pd-avd-01.location
  account_tier                  = "Premium"
  account_replication_type      = "LRS"
  account_kind                  = "FileStorage"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      azure_files_authentication
    ]
  }
}