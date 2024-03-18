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
    key                  = "tricor-connectivity.tfstate"
  }
}

############################################
#region Providers
############################################

# Default provider
provider "azurerm" {
  features {}
  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-connectivity-id
}

provider "azurerm" {
  alias = "connectivity"
  features {}

  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-connectivity-id
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

############################################
#endregion Remote States
############################################