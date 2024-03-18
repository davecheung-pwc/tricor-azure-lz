
resource "azurerm_storage_account" "storageaccount-terraform" {
  provider                  = azurerm.management
  name                      = "sagoeaspdterraform01"
  resource_group_name       = azurerm_resource_group.rg-go-eas-pd-terraform-01.name
  location                  = azurerm_resource_group.rg-go-eas-pd-terraform-01.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "ZRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "storagecontainer-tfstate" {
  provider              = azurerm.management
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storageaccount-terraform.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "storageaccount-log-eas" {
  provider                      = azurerm.management
  name                          = "sagoeaspdlog01"
  resource_group_name           = azurerm_resource_group.rg-go-eas-pd-log-01.name
  location                      = azurerm_resource_group.rg-go-eas-pd-log-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-log-sea" {
  provider                      = azurerm.management
  name                          = "sagoseapdlog01"
  resource_group_name           = azurerm_resource_group.rg-go-sea-pd-log-01.name
  location                      = azurerm_resource_group.rg-go-sea-pd-log-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-log-jpe" {
  provider                      = azurerm.management
  name                          = "sagojpepdlog01"
  resource_group_name           = azurerm_resource_group.rg-go-jpe-pd-log-01.name
  location                      = azurerm_resource_group.rg-go-jpe-pd-log-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-log-jpw" {
  provider                      = azurerm.management
  name                          = "sagojpwpdlog01"
  resource_group_name           = azurerm_resource_group.rg-go-jpw-pd-log-01.name
  location                      = azurerm_resource_group.rg-go-jpw-pd-log-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "LRS" # ZRS not available
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-image-eas" {
  provider                      = azurerm.management
  name                          = "sagoeaspdvmimg01"
  resource_group_name           = azurerm_resource_group.rg-go-eas-pd-vmimg-01.name
  location                      = azurerm_resource_group.rg-go-eas-pd-vmimg-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-veeam-eas" {
  provider                      = azurerm.management
  name                          = "sagoeaspdveeam01"
  resource_group_name           = azurerm_resource_group.rg-go-eas-pd-veeam-01.name
  location                      = azurerm_resource_group.rg-go-eas-pd-veeam-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-veeam-sea" {
  provider                      = azurerm.management
  name                          = "sagoseapdveeam01"
  resource_group_name           = azurerm_resource_group.rg-go-sea-pd-veeam-01.name
  location                      = azurerm_resource_group.rg-go-sea-pd-veeam-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-veeam-jpe" {
  provider                      = azurerm.management
  name                          = "sagojpepdveeam01"
  resource_group_name           = azurerm_resource_group.rg-go-jpe-pd-veeam-01.name
  location                      = azurerm_resource_group.rg-go-jpe-pd-veeam-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "ZRS"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "storageaccount-veeam-jpw" {
  provider                      = azurerm.management
  name                          = "sagojpwpdveeam01"
  resource_group_name           = azurerm_resource_group.rg-go-jpw-pd-veeam-01.name
  location                      = azurerm_resource_group.rg-go-jpw-pd-veeam-01.location
  account_tier                  = "Standard"
  account_kind                  = "StorageV2"
  account_replication_type      = "LRS" # ZRS not available
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}