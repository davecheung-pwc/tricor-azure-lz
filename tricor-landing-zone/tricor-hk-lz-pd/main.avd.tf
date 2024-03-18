locals {
  registration_token = azurerm_virtual_desktop_host_pool_registration_info.token-vdpool-hk-eas.token
}

data "azurerm_shared_image" "avd-w10" {
  provider            = azurerm.management
  name                = "Tricor-AVD-Windows10"
  gallery_name        = "gal_go_eas_pd_vmimg_01"
  resource_group_name = "rg-go-eas-pd-vmimg-01"
}

# AVD Workspace
resource "azurerm_virtual_desktop_workspace" "vdws-hk-eas" {
  provider = azurerm.landingzone_hk_pd
  # name              = "vdws-hk-eas-pd-avd-01"
  name                = "vdws-hk-jpe-pd-avd-01"
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  # location          = azurerm_resource_group.rg-hk-eas-pd-avd-01.location
  location = "japaneast" # temporarily provision in JPE as not yet available in EAS

  friendly_name = "Tricor Azure Virtual Desktop"
  description   = "Tricor Group AVD Workspace"
}

# AVD Host Pool
resource "azurerm_virtual_desktop_host_pool" "vdpool-hk-eas" {
  provider = azurerm.landingzone_hk_pd
  # name              = "vdpool-hk-eas-pd-avd-01"
  name                = "vdpool-hk-jpe-pd-avd-01"
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  # location          = azurerm_resource_group.rg-hk-eas-pd-avd-01.location
  location      = "japaneast" # temporarily provision in JPE as not yet available in EAS
  type          = "Pooled"
  friendly_name = "AVD-HK-Pool"

  validate_environment  = false
  start_vm_on_connect   = true
  custom_rdp_properties = "audiocapturemode:i:1;audiomode:i:0;"

  load_balancer_type       = "BreadthFirst"
  maximum_sessions_allowed = 20

  scheduled_agent_updates {
    enabled  = true
    timezone = "China Standard Time"
    schedule {
      day_of_week = "Sunday"
      hour_of_day = 2
    }
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "token-vdpool-hk-eas" {
  provider        = azurerm.landingzone_hk_pd
  hostpool_id     = azurerm_virtual_desktop_host_pool.vdpool-hk-eas.id
  expiration_date = timeadd(timestamp(), "336h") # initial valid for 14 days

  lifecycle {
    ignore_changes = [expiration_date]
  }
}

# AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag-hk-eas" {
  provider            = azurerm.landingzone_hk_pd
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  # location          = azurerm_resource_group.rg-hk-eas-pd-avd-01.location
  location     = "japaneast" # temporarily provision in JPE as not yet available in EAS
  host_pool_id = azurerm_virtual_desktop_host_pool.vdpool-hk-eas.id
  type         = "Desktop"
  # name              = "vdag-hk-eas-pd-avd-01"
  name                         = "vdag-hk-jpe-pd-avd-01"
  friendly_name                = "AVD Desktop AppGroup"
  description                  = "AVD application group"
  default_desktop_display_name = "AVD-HK"
  depends_on = [
    azurerm_virtual_desktop_host_pool.vdpool-hk-eas,
    azurerm_virtual_desktop_workspace.vdws-hk-eas
  ]
  lifecycle {
    ignore_changes = [
      friendly_name, default_desktop_display_name
    ]
  }
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "vdws-dag-hk-eas-asso" {
  provider             = azurerm.landingzone_hk_pd
  application_group_id = azurerm_virtual_desktop_application_group.dag-hk-eas.id
  workspace_id         = azurerm_virtual_desktop_workspace.vdws-hk-eas.id
}

# AVD Session Host

resource "azurerm_windows_virtual_machine" "vdpool-hk-eas-vm" {
  provider              = azurerm.landingzone_hk_pd
  count                 = var.avd_rdsh_count
  name                  = format("vm%s%s%s%s%02s", "hk", "eas", "pd", "avd", count.index + 1)
  resource_group_name   = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  location              = azurerm_resource_group.rg-hk-eas-pd-avd-01.location
  size                  = "Standard_D4s_v3"
  network_interface_ids = ["${azurerm_network_interface.vdpool-hk-eas-vm-nic.*.id[count.index]}"]
  provision_vm_agent    = true
  admin_username        = var.vm_localadmin_username
  admin_password        = var.vm_localadmin_password
  zone                  = (count.index % 3) + 1
  secure_boot_enabled   = true

  os_disk {
    name                 = format("vm%s%s%s%s%02s-OsDisk", "hk", "eas", "pd", "avd", count.index + 1)
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_shared_image.avd-w10.id

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azurerm_resource_group.rg-hk-eas-pd-avd-01,
    azurerm_network_interface.vdpool-hk-eas-vm-nic
  ]

  boot_diagnostics {
    storage_account_uri = null
  }

  lifecycle {
    ignore_changes = [admin_username, admin_password]
  }
}

resource "azurerm_network_interface" "vdpool-hk-eas-vm-nic" {
  provider            = azurerm.landingzone_hk_pd
  count               = var.avd_rdsh_count
  name                = format("vm%s%s%s%s%02s-nic01", "hk", "eas", "pd", "avd", count.index + 1)
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-avd-01.name
  location            = azurerm_resource_group.rg-hk-eas-pd-avd-01.location

  ip_configuration {
    name                          = format("vm%s%s%s%s%02s-nic01-config", "hk", "eas", "pd", "avd", count.index + 1)
    subnet_id                     = azurerm_subnet.lzsubnet-hk-pd-eas-avd.id
    private_ip_address_allocation = "Dynamic"
  }
}

# VM Extension
resource "azurerm_virtual_machine_extension" "vdpool-hk-eas-vm-ext-domainjoin" {
  provider                   = azurerm.landingzone_hk_pd
  count                      = var.avd_rdsh_count
  name                       = "ADDomainJoin"
  virtual_machine_id         = azurerm_windows_virtual_machine.vdpool-hk-eas-vm.*.id[count.index]
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "Name": "${var.vm_domain_name}",
      "OUPath": "${var.vm_domain_oupath}",
      "User": "${var.vm_domainjoin_username}@${var.vm_domain_name}",
      "Restart": "true",
      "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${var.vm_domainjoin_password}"
    }
PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}

resource "azurerm_virtual_machine_extension" "vdpool-hk-eas-vm-ext-aadlogon" {
  provider             = azurerm.landingzone_hk_pd
  count                = var.avd_rdsh_count
  name                 = "AADLoginForWindows"
  virtual_machine_id   = azurerm_windows_virtual_machine.vdpool-hk-eas-vm.*.id[count.index]
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"

  timeouts {
    create = "15m"
  }
}

resource "azurerm_virtual_machine_extension" "vdpool-hk-eas-vm-ext-avd_dsc" {
  provider                   = azurerm.landingzone_hk_pd
  count                      = var.avd_rdsh_count
  name                       = "AVDHostPoolConfiguration"
  virtual_machine_id         = azurerm_windows_virtual_machine.vdpool-hk-eas-vm.*.id[count.index]
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.83"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName":"${azurerm_virtual_desktop_host_pool.vdpool-hk-eas.name}",
        "aadJoin": true
      }
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "properties": {
      "registrationInfoToken": "${local.registration_token}"
    }
  }
PROTECTED_SETTINGS

  depends_on = [
    azurerm_virtual_machine_extension.vdpool-hk-eas-vm-ext-aadlogon,
    azurerm_virtual_desktop_host_pool.vdpool-hk-eas
  ]

  timeouts {
    create = "15m"
  }

  lifecycle {
    ignore_changes = [
      protected_settings
    ]
  }
}

# Diagnostic
resource "azurerm_monitor_diagnostic_setting" "diag-vdws-hk-eas-pd-avd-01" {
  provider                       = azurerm.landingzone_hk_pd
  name                           = "diag-${azurerm_virtual_desktop_workspace.vdws-hk-eas.name}"
  target_resource_id             = azurerm_virtual_desktop_workspace.vdws-hk-eas.id
  log_analytics_workspace_id     = data.terraform_remote_state.management.outputs.loganalyticsworkspace-log-eas-id
  log_analytics_destination_type = "AzureDiagnostics"
  depends_on                     = [azurerm_virtual_desktop_workspace.vdws-hk-eas]

  enabled_log {
    category = "Error"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Checkpoint"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Management"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Feed"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag-vdpool-hk-eas-pd-avd-01" {
  provider                       = azurerm.landingzone_hk_pd
  name                           = "diag-${azurerm_virtual_desktop_host_pool.vdpool-hk-eas.name}"
  target_resource_id             = azurerm_virtual_desktop_host_pool.vdpool-hk-eas.id
  log_analytics_workspace_id     = data.terraform_remote_state.management.outputs.loganalyticsworkspace-log-eas-id
  log_analytics_destination_type = "AzureDiagnostics"
  depends_on                     = [azurerm_virtual_desktop_host_pool.vdpool-hk-eas]

  enabled_log {
    category = "Error"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Checkpoint"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Management"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Connection"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "HostRegistration"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "AgentHealthStatus"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "NetworkData"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "SessionHostManagement"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
}

resource "azurerm_monitor_diagnostic_setting" "diag-dag-hk-eas-pd-avd-01" {
  provider                       = azurerm.landingzone_hk_pd
  name                           = "diag-${azurerm_virtual_desktop_application_group.dag-hk-eas.name}"
  target_resource_id             = azurerm_virtual_desktop_application_group.dag-hk-eas.id
  log_analytics_workspace_id     = data.terraform_remote_state.management.outputs.loganalyticsworkspace-log-eas-id
  log_analytics_destination_type = "AzureDiagnostics"
  depends_on                     = [azurerm_virtual_desktop_application_group.dag-hk-eas]

  enabled_log {
    category = "Checkpoint"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Error"

    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "Management"

    retention_policy {
      enabled = false
    }
  }

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type
    ]
  }
}
