resource "azurerm_resource_group" "rg-go-eas-pd-terraform-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-terraform-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Terraform"
    ApplicationId       = "tf"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-log-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-log-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Monitor"
    ApplicationId       = "azm"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-sea-pd-log-01" {
  provider = azurerm.management
  name     = "rg-go-sea-pd-log-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Monitor"
    ApplicationId       = "azm"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpe-pd-log-01" {
  provider = azurerm.management
  name     = "rg-go-jpe-pd-log-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Monitor"
    ApplicationId       = "azm"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpw-pd-log-01" {
  provider = azurerm.management
  name     = "rg-go-jpw-pd-log-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Monitor"
    ApplicationId       = "azm"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-vmimg-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-vmimg-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Image Gallery"
    ApplicationId       = "img"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-monitor-01" {
  provider = azurerm.management
  name     = "rg-go-sea-pd-monitor-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Monitor"
    ApplicationId       = "azm"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-mgmtnet-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-mgmtnet-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Management Virtual Network"
    ApplicationId       = "mgmtnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-sea-pd-mgmtnet-01" {
  provider = azurerm.management
  name     = "rg-go-sea-pd-mgmtnet-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Management Virtual Network"
    ApplicationId       = "mgmtnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpe-pd-mgmtnet-01" {
  provider = azurerm.management
  name     = "rg-go-jpe-pd-mgmtnet-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Management Virtual Network"
    ApplicationId       = "mgmtnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpw-pd-mgmtnet-01" {
  provider = azurerm.management
  name     = "rg-go-jpw-pd-mgmtnet-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Management Virtual Network"
    ApplicationId       = "mgmtnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-veeam-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-veeam-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Veeam Backup for Microsoft Azure"
    ApplicationId       = "veeam"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-sea-pd-veeam-01" {
  provider = azurerm.management
  name     = "rg-go-sea-pd-veeam-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Veeam Backup for Microsoft Azure"
    ApplicationId       = "veeam"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpe-pd-veeam-01" {
  provider = azurerm.management
  name     = "rg-go-jpe-pd-veeam-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Veeam Backup for Microsoft Azure"
    ApplicationId       = "veeam"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpw-pd-veeam-01" {
  provider = azurerm.management
  name     = "rg-go-jpw-pd-veeam-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Veeam Backup for Microsoft Azure"
    ApplicationId       = "veeam"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}