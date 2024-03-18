## Add the Site and Environment tags to subscriptions

resource "azurerm_subscription_policy_assignment" "add_site_tag" {
  provider             = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                 = "Add Site tag to subscription"
  display_name         = "Add Site tag to subscription"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1"
  subscription_id      = format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_SITE_ENV-id) # TODO: UPDATE FOR NEW SUBSCRIPTION
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "Site"
    }
    tagValue = {
      value = "HK" # TODO: UPDATE FOR NEW SUBSCRIPTION
    }
  })
}

resource "azurerm_subscription_policy_assignment" "add_environment_tag" {
  provider             = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                 = "Add Environment tag to subscription"
  display_name         = "Add Environment tag to subscription"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/61a4d60b-7326-440e-8051-9f94394d4dd1"
  subscription_id      = format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_SITE_ENV-id) # TODO: UPDATE FOR NEW SUBSCRIPTION
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
    tagValue = {
      value = "PROD" # TODO: UPDATE FOR NEW SUBSCRIPTION
    }
  })
}

resource "azurerm_subscription_policy_assignment" "allowed_location" {
  provider             = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                 = "Allowed locations"
  display_name         = "Allowed locations"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  subscription_id      = format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_SITE_ENV-id) # TODO: UPDATE FOR NEW SUBSCRIPTION
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    listOfAllowedLocations = {
      value = ["East Asia"] # TODO: UPDATE FOR NEW SUBSCRIPTION
    }
  })

  # not_scopes = [ # TODO: UPDATE FOR NEW SUBSCRIPTION
  #   azurerm_resource_group.avd.id
  # ]
}

resource "azurerm_subscription_policy_assignment" "allowed_rg_location" {
  provider             = azurerm.landingzone_SITE_ENV  # TODO: UPDATE FOR NEW SUBSCRIPTION
  name                 = "Allowed locations for resource groups"
  display_name         = "Allowed locations for resource groups"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
  subscription_id      = format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_SITE_ENV-id) # TODO: UPDATE FOR NEW SUBSCRIPTION
  location             = "East Asia" # TODO: UPDATE FOR NEW SUBSCRIPTION
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    listOfAllowedLocations = {
      value = ["East Asia"] # TODO: UPDATE FOR NEW SUBSCRIPTION
    }
  })
}
