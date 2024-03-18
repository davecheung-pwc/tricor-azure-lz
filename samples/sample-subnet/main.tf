locals {
  app_site   = "hk"                            # TODO: UPDATE
  app_region = "eas"                           # TODO: UPDATE
  app_env    = "pd"                            # TODO: UPDATE
  app_name   = "samp"                          # TODO: UPDATE
  app_ver    = "01"                            # TODO: UPDATE
  tags = {                                     # define tags here
    Site                = "HK"                 # TODO: UPDATE
    ApplicationId       = "samp"               # TODO: UPDATE
    ApplicationName     = "Sample Application" # TODO: UPDATE
    ApplicationOwner    = "TBC"                # TODO: UPDATE
    BusinessCriticality = "Standard"           # TODO: UPDATE
    BusinessUnit        = "IT"                 # TODO: UPDATE
    CostCenter          = "TBC"                # TODO: UPDATE
    DataClassification  = "Restricted"         # TODO: UPDATE
    Envrionment         = "PROD"               # TODO: UPDATE
  }
}

data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s-%s-%s-%s", local.app_site, local.app_region, local.app_env, local.app_name, local.app_ver) # TODO: REVIEW/UPDATE
}

data "azurerm_virtual_network" "vnet" {
  name                = format("vnet-%s-%s-%s-net-01", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
  resource_group_name = format("rg-%s-%s-%s-net-01", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
}

data "azurerm_route_table" "rt-default" {
  name                = format("rt-vnet-%s-%s-%s-net-01-default", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
  resource_group_name = format("rg-%s-%s-%s-net-01", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
}

resource "azurerm_subnet" "app" {
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  name                 = format("vnet-%s-%s-%s-net-01-snet-%s-%s-01", local.app_site, local.app_region, local.app_env, local.app_name, "app")
  address_prefixes     = ["10.54.0.0/28"] # TODO: UPDATE
}

resource "azurerm_subnet" "db" {
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  name                 = format("vnet-%s-%s-%s-net-01-snet-%s-%s-01", local.app_site, local.app_region, local.app_env, local.app_name, "db")
  address_prefixes     = ["10.54.0.16/28"] # TODO: UPDATE
}

resource "azurerm_subnet_route_table_association" "app" {
  subnet_id      = azurerm_subnet.app.id
  route_table_id = data.azurerm_route_table.rt-default.id
}

resource "azurerm_subnet_route_table_association" "db" {
  subnet_id      = azurerm_subnet.db.id
  route_table_id = data.azurerm_route_table.rt-default.id
}

module "nsg-app" {
  source = "../../modules/azurerm-nsg-baseline"

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tags
  subnet              = azurerm_subnet.app

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.app
  ]
}

module "nsg-db" {
  source = "../../modules/azurerm-nsg-baseline"

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tags
  subnet              = azurerm_subnet.db

  allow_samesubnet                   = false
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.db
  ]
}
