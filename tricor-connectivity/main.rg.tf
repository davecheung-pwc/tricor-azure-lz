resource "azurerm_resource_group" "rg-go-eas-pd-conn-01" {
  provider = azurerm.connectivity
  name     = "rg-go-eas-pd-conn-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Virtual WAN"
    ApplicationId       = "conn"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-connnet-01" {
  provider = azurerm.connectivity
  name     = "rg-go-eas-pd-connnet-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Connectivity VNet"
    ApplicationId       = "connnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-sea-pd-connnet-01" {
  provider = azurerm.connectivity
  name     = "rg-go-sea-pd-connnet-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Connectivity VNet"
    ApplicationId       = "connnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpe-pd-connnet-01" {
  provider = azurerm.connectivity
  name     = "rg-go-jpe-pd-connnet-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Connectivity VNet"
    ApplicationId       = "connnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpw-pd-connnet-01" {
  provider = azurerm.connectivity
  name     = "rg-go-jpw-pd-connnet-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Connectivity VNet"
    ApplicationId       = "connnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-fw-01" {
  provider = azurerm.connectivity
  name     = "rg-go-eas-pd-fw-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Fortigate NGFW"
    ApplicationId       = "fw"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-dns-01" {
  provider = azurerm.connectivity
  name     = "rg-go-eas-pd-dns-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Private DNS"
    ApplicationId       = "dns"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}