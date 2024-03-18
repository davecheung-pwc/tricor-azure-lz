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

data "azurerm_shared_image" "image-ws2022" {
  provider            = azurerm.management
  name                = "Tricor-WindowsServer2022"
  gallery_name        = "gal_go_eas_pd_vmimg_01"
  resource_group_name = "rg-go-eas-pd-vmimg-01"
}

data "azurerm_shared_image" "image-ubuntu22" {
  provider            = azurerm.management
  name                = "Tricor-UbuntuServer22.04"
  gallery_name        = "gal_go_eas_pd_vmimg_01"
  resource_group_name = "rg-go-eas-pd-vmimg-01"
}

data "azurerm_resource_group" "rg" {
  name = format("rg-%s-%s-%s-%s-%s", local.app_site, local.app_region, local.app_env, local.app_name, local.app_ver) # TODO: REVIEW/UPDATE
}

data "azurerm_subnet" "subnet" {
  virtual_network_name = format("vnet-%s-%s-%s-net-01", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
  name                 = format("vnet-%s-%s-%s-net-01-snet-%s-01", local.app_site, local.app_region, local.app_env, local.app_name) # TODO: REVIEW/UPDATE
  resource_group_name  = format("rg-%s-%s-%s-net-01", local.app_site, local.app_region, local.app_env) # TODO: REVIEW/UPDATE
}

#######################################
#region Windows VM
#######################################

resource "azurerm_windows_virtual_machine" "vm_windows" {
  name                  = format("vm%s%s%s%s%02s", local.app_site, local.app_region, local.app_env, local.app_name, "01") # TODO: REVIEW/UPDATE
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  size                  = "Standard_D2s_v3" # TODO: REVIEW/UPDATE
  network_interface_ids = azurerm_network_interface.vm_windows_nic.id
  provision_vm_agent    = true
  admin_username        = var.vm_localadmin_username
  admin_password        = var.vm_localadmin_password
  zone                  = 1 # 1 or 2 or 3
  secure_boot_enabled   = true

  tags = local.tags

  os_disk {
    name                 = format("vm%s%s%s%s%02s-OsDisk", local.app_site, local.app_region, local.app_env, local.app_name, "01") # TODO: REVIEW/UPDATE
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Standard_LRS or StandardSSD_LRS or Premium_LRS or StandardSSD_ZRS or Premium_ZRS
  }

  source_image_id = data.azurerm_shared_image.image-ws2022.id

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_network_interface.vm_windows_nic
  ]

  boot_diagnostics {
    storage_account_uri = null
  }

  lifecycle {
    ignore_changes = [admin_username, admin_password]
  }
}

resource "azurerm_network_interface" "vm_windows_nic" {
  name                = format("vm%s%s%s%s%02s-nic01", local.vm_name_site, local.vm_name_region, local.vm_name_env, local.vm_name_app, "01") # TODO: REVIEW/UPDATE
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  ip_configuration {
    name                          = format("vm%s%s%s%s%02s-nic01-config", local.vm_name_site, local.vm_name_region, local.vm_name_env, local.vm_name_app, "01") # TODO: REVIEW/UPDATE
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#######################################
#endregion Windows VM
#######################################

#######################################
#region Linux VM
#######################################

resource "azurerm_linux_virtual_machine" "vm_linux" {
  name                            = format("vm%s%s%s%s%02s", local.app_site, local.app_region, local.app_env, local.app_name, "02") # TODO: REVIEW/UPDATE
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  size                            = "Standard_D2s_v3" # TODO: REVIEW/UPDATE
  network_interface_ids           = [azurerm_network_interface.vm_linux_nic.id]
  provision_vm_agent              = true
  admin_username                  = var.vm_localadmin_username
  admin_password                  = var.vm_localadmin_password
  disable_password_authentication = false
  zone                            = 1 # 1 or 2 or 3
  secure_boot_enabled             = true

  tags = local.tags

  os_disk {
    name                 = format("vm%s%s%s%s%02s-OsDisk", local.app_site, local.app_region, local.app_env, local.app_name, "02") # TODO: REVIEW/UPDATE
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Standard_LRS or StandardSSD_LRS or Premium_LRS or StandardSSD_ZRS or Premium_ZRS
  }

  source_image_id = data.azurerm_shared_image.image-ubuntu22.id

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    data.azurerm_resource_group.rg,
    azurerm_network_interface.vm_linux_nic
  ]

  boot_diagnostics {
    storage_account_uri = null
  }

  lifecycle {
    ignore_changes = [admin_username, admin_password]
  }
}

resource "azurerm_network_interface" "vm_linux_nic" {
  name                = format("vm%s%s%s%s%02s-nic01", local.vm_name_site, local.vm_name_region, local.vm_name_env, local.vm_name_app, "02") # TODO: REVIEW/UPDATE
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  ip_configuration {
    name                          = format("vm%s%s%s%s%02s-nic01-config", local.vm_name_site, local.vm_name_region, local.vm_name_env, local.vm_name_app, "02") # TODO: REVIEW/UPDATE
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

#######################################
#endregion Linux VM
#######################################
