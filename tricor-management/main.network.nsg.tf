############################################
#region NSG - Management - EAS
############################################

module "nsg-eas-veeam" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-eas-pd-veeam-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-veeam-01.location
  tags                = {}
  subnet              = azurerm_subnet.managementsubnet-eas-veeam

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-eas-pd-veeam-01,
    azurerm_subnet.managementsubnet-eas-veeam
  ]
}

module "nsg-eas-vmimg" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-eas-pd-vmimg-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-vmimg-01.location
  tags                = {}
  subnet              = azurerm_subnet.managementsubnet-eas-vmimg

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-eas-pd-vmimg-01,
    azurerm_subnet.managementsubnet-eas-vmimg
  ]
}

#endregion NSG - Management - EAS
############################################

############################################
#region NSG - Management - SEA
############################################

module "nsg-sea-veeam" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-sea-pd-veeam-01.name
  location            = azurerm_resource_group.rg-go-sea-pd-veeam-01.location
  tags                = {}
  subnet              = azurerm_subnet.managementsubnet-sea-veeam

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-sea-pd-veeam-01,
    azurerm_subnet.managementsubnet-sea-veeam
  ]
}

#endregion NSG - Management - SEA
############################################

############################################
#region NSG - Management - JPE
############################################

module "nsg-jpe-veeam" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-jpe-pd-veeam-01.name
  location            = azurerm_resource_group.rg-go-jpe-pd-veeam-01.location
  tags                = {}
  subnet              = azurerm_subnet.managementsubnet-jpe-veeam

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-jpe-pd-veeam-01,
    azurerm_subnet.managementsubnet-jpe-veeam
  ]
}

#endregion NSG - Management - JPE
############################################

############################################
#region NSG - Management - JPW
############################################

module "nsg-jpw-veeam" {
  source = "../modules/azurerm-nsg-baseline"

  resource_group_name = azurerm_resource_group.rg-go-jpw-pd-veeam-01.name
  location            = azurerm_resource_group.rg-go-jpw-pd-veeam-01.location
  tags                = {}
  subnet              = azurerm_subnet.managementsubnet-jpw-veeam

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_resource_group.rg-go-jpw-pd-veeam-01,
    azurerm_subnet.managementsubnet-jpw-veeam
  ]
}

#endregion NSG - Management - JPW
############################################
