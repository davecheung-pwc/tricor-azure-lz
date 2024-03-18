terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.44.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.35.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-root.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias = "management"
  features {}

  subscription_id = data.terraform_remote_state.subscriptions.outputs.subscription-management-id
}

provider "azuread" {
  tenant_id = "004beac5-0dc0-4a34-9fe4-2d0eb84b7021"
}

data "azurerm_billing_enrollment_account_scope" "customer_billing_scope" {
  billing_account_name    = "82815542"
  enrollment_account_name = "333689"
}

data "terraform_remote_state" "subscriptions" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-go-eas-pd-terraform-01"
    storage_account_name = "sagoeaspdterraform01"
    container_name       = "tfstate"
    key                  = "tricor-root.tfstate"
  }
}