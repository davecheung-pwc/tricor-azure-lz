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
    key                  = "tricor-landing-zone/tricor-SITE-lz-ENV.tfstate" # TODO: UPDATE
  }
}

############################################
#region Providers
############################################

# Default provider
provider "azurerm" {
  features {}
  
  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_SITE_ENV-id # TODO: UPDATE
}

provider "azurerm" {
  alias = "management"
  features {}

  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-management-id
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

data "terraform_remote_state" "management" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-management.tfstate"
  }
}

############################################
#endregion Remote States
############################################