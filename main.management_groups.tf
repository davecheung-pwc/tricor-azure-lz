resource "azurerm_management_group" "lz_root_management_group" {
  name                       = "MG-Tricor-LZ"
  display_name               = "MG-Tricor-LZ"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/Tricor-Root-Group" // id of root management group
}

resource "azurerm_management_group" "platform_management_group" {
  name                       = "mg-tricor-platform"
  display_name               = "mg-tricor-platform"
  parent_management_group_id = azurerm_management_group.lz_root_management_group.id
}

resource "azurerm_management_group" "connectivity_management_group" {
  name                       = "mg-tricor-connectivity"
  display_name               = "mg-tricor-connectivity"
  parent_management_group_id = azurerm_management_group.platform_management_group.id

  subscription_ids = [
    azurerm_subscription.connectivity.subscription_id
  ]
}

resource "azurerm_management_group" "identity_management_group" {
  name                       = "mg-tricor-identity"
  display_name               = "mg-tricor-identity"
  parent_management_group_id = azurerm_management_group.platform_management_group.id

  subscription_ids = [
    azurerm_subscription.identity.subscription_id
  ]
}

resource "azurerm_management_group" "mgmt_management_group" {
  name                       = "mg-tricor-management"
  display_name               = "mg-tricor-management"
  parent_management_group_id = azurerm_management_group.platform_management_group.id

  subscription_ids = [
    azurerm_subscription.management.subscription_id
  ]
}

resource "azurerm_management_group" "landing_zone_management_group" {
  name                       = "mg-tricor-landing-zone"
  display_name               = "mg-tricor-landing-zone"
  parent_management_group_id = azurerm_management_group.lz_root_management_group.id
}

resource "azurerm_management_group" "go_management_group" {
  name                       = "mg-tricor-go"
  display_name               = "mg-tricor-go"
  parent_management_group_id = azurerm_management_group.landing_zone_management_group.id

  subscription_ids = [
    azurerm_subscription.landingzone_go_np.subscription_id,
    azurerm_subscription.landingzone_go_pd.subscription_id
  ]
}

resource "azurerm_management_group" "hk_management_group" {
  name                       = "mg-tricor-hk"
  display_name               = "mg-tricor-hk"
  parent_management_group_id = azurerm_management_group.landing_zone_management_group.id

  subscription_ids = [
    azurerm_subscription.landingzone_hk_np.subscription_id,
    azurerm_subscription.landingzone_hk_pd.subscription_id
  ]
}