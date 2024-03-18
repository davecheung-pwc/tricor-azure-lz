############################################
#region Resource Group - Identity - EAS
############################################

resource "azurerm_resource_group" "rg-go-eas-pd-idnet-01" {
  provider = azurerm.identity
  name     = "rg-go-eas-pd-idnet-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Identity VNet"
    ApplicationId       = "idnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-eas-pd-addc-01" {
  provider = azurerm.identity
  name     = "rg-go-eas-pd-addc-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Active Directory Domain Controller"
    ApplicationId       = "addc"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

#endregion Resource Group - Identity - EAS
############################################

############################################
#region Resource Group - Identity - SEA
############################################

resource "azurerm_resource_group" "rg-go-sea-pd-idnet-01" {
  provider = azurerm.identity
  name     = "rg-go-sea-pd-idnet-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Identity VNet"
    ApplicationId       = "idnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-sea-pd-addc-01" {
  provider = azurerm.identity
  name     = "rg-go-sea-pd-addc-01"
  location = "Southeast Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Active Directory Domain Controller"
    ApplicationId       = "addc"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

#endregion Resource Group - Identity - SEA
############################################

############################################
#region Resource Group - Identity - JPE
############################################

resource "azurerm_resource_group" "rg-go-jpe-pd-idnet-01" {
  provider = azurerm.identity
  name     = "rg-go-jpe-pd-idnet-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Identity VNet"
    ApplicationId       = "idnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpe-pd-addc-01" {
  provider = azurerm.identity
  name     = "rg-go-jpe-pd-addc-01"
  location = "Japan East"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Active Directory Domain Controller"
    ApplicationId       = "addc"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

#endregion Resource Group - Identity - JPE
############################################

############################################
#region Resource Group - Identity - JPW
############################################

resource "azurerm_resource_group" "rg-go-jpw-pd-idnet-01" {
  provider = azurerm.identity
  name     = "rg-go-jpw-pd-idnet-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Identity VNet"
    ApplicationId       = "idnet"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_resource_group" "rg-go-jpw-pd-addc-01" {
  provider = azurerm.identity
  name     = "rg-go-jpw-pd-addc-01"
  location = "Japan West"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Active Directory Domain Controller"
    ApplicationId       = "addc"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

#endregion Resource Group - Identity - JPW
############################################