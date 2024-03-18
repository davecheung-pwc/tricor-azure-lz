# Subscriptions under Platform Management Group

resource "azurerm_subscription" "connectivity" {
  alias             = "connectivity"
  subscription_name = "sub-tricor-connectivity"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

resource "azurerm_subscription" "management" {
  alias             = "management"
  subscription_name = "sub-tricor-management"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

resource "azurerm_subscription" "identity" {
  alias             = "identity"
  subscription_name = "sub-tricor-identity"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

# Subscriptions under Landing Zone Management Group

resource "azurerm_subscription" "landingzone_go_np" {
  alias             = "landingzone_go_np"
  subscription_name = "sub-tricor-go-lz-np"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

resource "azurerm_subscription" "landingzone_go_pd" {
  alias             = "landingzone_go_pd"
  subscription_name = "sub-tricor-go-lz-pd"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

resource "azurerm_subscription" "landingzone_hk_np" {
  alias             = "landingzone_hk_np"
  subscription_name = "sub-tricor-hk-lz-np"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

resource "azurerm_subscription" "landingzone_hk_pd" {
  alias             = "landingzone_hk_pd"
  subscription_name = "sub-tricor-hk-lz-pd"
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.customer_billing_scope.id
  timeouts {
    create = "1h"
  }
}

