# Active Directory Domain Controller Host

resource "azurerm_windows_virtual_machine" "addc-go-eas-vm" {
  provider              = azurerm.identity
  count                 = var.addc_count_per_region
  name                  = format("vm%s%s%s%s%02s", "go", "eas", "pd", "dc", count.index + 1)
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-addc-01.name
  location              = azurerm_resource_group.rg-go-eas-pd-addc-01.location
  size                  = "Standard_D2s_v3"
  network_interface_ids = ["${azurerm_network_interface.addc-go-eas-vm-nic.*.id[count.index]}"]
  provision_vm_agent    = true
  admin_username        = var.vm_localadmin_username
  admin_password        = var.vm_localadmin_password
  zone                  = (count.index % 3) + 1

  tags = {
    "ApplicationId"       = "addc"
    "ApplicationName"     = "Active Directory Domain Controller"
    "ApplicationOwner"    = "TBC"
    "BusinessCriticality" = "Standard"
    "BusinessUnit"        = "IT"
    "CostCenter"          = "TBC"
    "DataClassification"  = "Restricted"
    "Environment"         = "PROD"
    "Site"                = "GO"
  }

  os_disk {
    name                 = format("vm%s%s%s%s%02s-OsDisk", "go", "eas", "pd", "dc", count.index + 1)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  depends_on = [
    azurerm_resource_group.rg-go-eas-pd-addc-01,
    azurerm_network_interface.addc-go-eas-vm-nic
  ]

  lifecycle {
    ignore_changes = [admin_username, admin_password]
  }
}

resource "azurerm_network_interface" "addc-go-eas-vm-nic" {
  provider            = azurerm.identity
  count               = var.addc_count_per_region
  name                = format("vm%s%s%s%s%02s-nic01", "go", "eas", "pd", "dc", count.index + 1)
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-addc-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-addc-01.location

  tags = {
    "ApplicationId"       = "addc"
    "ApplicationName"     = "Active Directory Domain Controller"
    "ApplicationOwner"    = "TBC"
    "BusinessCriticality" = "Standard"
    "BusinessUnit"        = "IT"
    "CostCenter"          = "TBC"
    "DataClassification"  = "Restricted"
    "Environment"         = "PROD"
    "Site"                = "GO"
  }

  ip_configuration {
    name                          = format("vm%s%s%s%s%02s-nic01-config", "go", "eas", "pd", "dc", count.index + 1)
    subnet_id                     = azurerm_subnet.identitysubnet-eas-addc.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.eas_addc_ip_addresses[count.index]
  }
}
