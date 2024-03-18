data "azurerm_resource_group" "rg-hk-eas-pd-isp-01" {
  name = "rg-hk-eas-pd-isp-01"
}

resource "azurerm_subnet" "lzsubnet-hk-pd-eas-isp-app" {
  provider             = azurerm.landingzone_hk_pd
  resource_group_name  = azurerm_resource_group.rg-hk-eas-pd-net-01.name
  virtual_network_name = azurerm_virtual_network.lzvnet-hk-pd-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.lzvnet-hk-pd-eas.name, "snet-isp-app-01")
  address_prefixes     = ["10.52.0.0/28"]
}

resource "azurerm_subnet" "lzsubnet-hk-pd-eas-isp-db" {
  provider             = azurerm.landingzone_hk_pd
  resource_group_name  = azurerm_resource_group.rg-hk-eas-pd-net-01.name
  virtual_network_name = azurerm_virtual_network.lzvnet-hk-pd-eas.name
  name                 = format("%s-%s", azurerm_virtual_network.lzvnet-hk-pd-eas.name, "snet-isp-db-01")
  address_prefixes     = ["10.52.0.16/28"]
}

resource "azurerm_subnet_route_table_association" "lzrt-hk-pd-eas_association_lzvnet-hk-pd-eas-isp-app" {
  provider       = azurerm.landingzone_hk_pd
  subnet_id      = azurerm_subnet.lzsubnet-hk-pd-eas-isp-app.id
  route_table_id = azurerm_route_table.lzrt-hk-pd-eas.id
}

resource "azurerm_subnet_route_table_association" "lzrt-hk-pd-eas_association_lzvnet-hk-pd-eas-isp-db" {
  provider       = azurerm.landingzone_hk_pd
  subnet_id      = azurerm_subnet.lzsubnet-hk-pd-eas-isp-db.id
  route_table_id = azurerm_route_table.lzrt-hk-pd-eas.id
}

module "nsg-hk-pd-eas-isp-app" {
  source = "../../modules/azurerm-nsg-baseline"

  resource_group_name = data.azurerm_resource_group.rg-hk-eas-pd-isp-01.name
  location            = data.azurerm_resource_group.rg-hk-eas-pd-isp-01.location
  tags                = {}
  subnet              = azurerm_subnet.lzsubnet-hk-pd-eas-isp-app

  allow_samesubnet                   = true
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.lzsubnet-hk-pd-eas-isp-app
  ]
}

module "nsg-hk-pd-eas-isp-db" {
  source = "../../modules/azurerm-nsg-baseline"

  resource_group_name = data.azurerm_resource_group.rg-hk-eas-pd-isp-01.name
  location            = data.azurerm_resource_group.rg-hk-eas-pd-isp-01.location
  tags                = {}
  subnet              = azurerm_subnet.lzsubnet-hk-pd-eas-isp-db

  allow_samesubnet                   = false
  management_subnet_address_prefixes = var.nsg_management_subnet_address_prefixes

  depends_on = [
    azurerm_subnet.lzsubnet-hk-pd-eas-isp-db
  ]
}
