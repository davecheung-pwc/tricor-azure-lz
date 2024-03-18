terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.44.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-identity.tfstate"
  }
}

############################################
#region Providers
############################################

# Default provider
provider "azurerm" {
  features {}
  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-identity-id
}

provider "azurerm" {
  alias = "connectivity"
  features {}

  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-connectivity-id
}

provider "azurerm" {
  alias = "identity"
  features {}

  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-identity-id
}

############################################
#endregion Providers
############################################

############################################
#region Remote States
############################################
data "terraform_remote_state" "subscriptions" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-root.tfstate"
  }
}

data "terraform_remote_state" "connectivity" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-connectivity.tfstate"
  }
}

############################################
#endregion Remote States
############################################