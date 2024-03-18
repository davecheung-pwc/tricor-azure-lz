# Action Group for alerts
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra" {
  name                = "Email Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "Cloud Infra"

  email_receiver {
    name                    = "Winton WC Cheng"
    email_address           = "winton.wc.cheng@hk.tricorglobal.com"
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "Samimbadshah"
    email_address           = "Samimbadshah@my.tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor HK resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_hk" {
  name                = "Hong Kong Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "HK Cloud"

  email_receiver {
    name                    = "HK Cloud Infra Team"
    email_address           = "HKCloudInfra@tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor GO resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_go" {
  name                = "Group Office Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "GO Cloud"

  email_receiver {
    name                    = "GO Cloud Infra Team"
    email_address           = "GOCloudInfra@tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor JP resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_jp" {
  name                = "Japan Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "JP Cloud"

  email_receiver {
    name                    = "JP Cloud Infra Team"
    email_address           = "JPCloudInfra@tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor MY resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_my" {
  name                = "Malaysia Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "MY Cloud"

  email_receiver {
    name                    = "MY Cloud Infra Team"
    email_address           = "MYCloudInfra@tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor OS resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_or" {
  name                = "Orisoft Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "OR Cloud"

  email_receiver {
    name                    = "OR Cloud Infra Team"
    email_address           = "OrCloudInfra@tricorglobal.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Action Group for alerts related to Tricor SG resources
resource "azurerm_monitor_action_group" "action_group_email_cloud_infra_sg" {
  name                = "Singapore Cloud Infra Team"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  short_name          = "SG Cloud"

  email_receiver {
    name                    = "SG Cloud Infra Team"
    email_address           = "SGCloudInfra@tricorgloba.com"
    use_common_alert_schema = true
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Service Health Alert
resource "azurerm_monitor_activity_log_alert" "alert_mgmt_service_health" {
  name                = "alert-sub-tricor-management-service-health"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  scopes              = [format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-management-id)]
  description         = "Action will be triggered when ServiceHealth event occurs."

  criteria {
    category = "ServiceHealth"
    service_health {
      locations = ["East Asia", "Southeast Asia", "Japan East", "Japan West"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_email_cloud_infra.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_conn_service_health" {
  name                = "alert-sub-tricor-connectivity-service-health"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  scopes              = [format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-connectivity-id)]
  description         = "Action will be triggered when ServiceHealth event occurs."

  criteria {
    category = "ServiceHealth"
    service_health {
      locations = ["East Asia", "Southeast Asia", "Japan East", "Japan West"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_email_cloud_infra.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_iden_service_health" {
  name                = "alert-sub-tricor-identity-service-health"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  scopes              = [format("/subscriptions/%s", data.terraform_remote_state.subscriptions.outputs.subscription-identity-id)]
  description         = "Action will be triggered when ServiceHealth event occurs."

  criteria {
    category = "ServiceHealth"
    service_health {
      locations = ["East Asia", "Southeast Asia", "Japan East", "Japan West"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_email_cloud_infra.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alerts for Virtual Machine
module "standard_alerts_hk_np" {
  source = "./modules/standard-alerts"

  site                = "HK"
  subscription_name   = "sub-tricor-hk-lz-np"
  subscription_id     = data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_hk_np-id
  locations           = ["East Asia"]
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  action_group_id     = azurerm_monitor_action_group.action_group_email_cloud_infra_hk.id
}

# Metric Alerts for Virtual Machine
module "standard_alerts_hk_pd" {
  source = "./modules/standard-alerts"

  site                = "HK"
  subscription_name   = "sub-tricor-hk-lz-pd"
  subscription_id     = data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_hk_pd-id
  locations           = ["East Asia"]
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  action_group_id     = azurerm_monitor_action_group.action_group_email_cloud_infra_hk.id
}

# Metric Alerts for Virtual Machine
module "standard_alerts_go_np" {
  source = "./modules/standard-alerts"

  site                = "HK"
  subscription_name   = "sub-tricor-go-lz-np"
  subscription_id     = data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_go_np-id
  locations           = ["East Asia"]
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  action_group_id     = azurerm_monitor_action_group.action_group_email_cloud_infra_go.id
}

# Metric Alerts for Virtual Machine
module "standard_alerts_go_pd" {
  source = "./modules/standard-alerts"

  site                = "HK"
  subscription_name   = "sub-tricor-go-lz-pd"
  subscription_id     = data.terraform_remote_state.subscriptions.outputs.subscription-landingzone_go_pd-id
  locations           = ["East Asia"]
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  action_group_id     = azurerm_monitor_action_group.action_group_email_cloud_infra_go.id
}

# Resource Health Alerts
resource "azurerm_monitor_activity_log_alert" "alert_conn_vm_resource_health" {
  name                = "alert-sub-tricor-connectivity-vm-resource-health"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  scopes              = ["/subscriptions/${data.terraform_remote_state.subscriptions.outputs.subscription-connectivity-id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Virtual machine."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.Compute/virtualMachines"
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_email_cloud_infra_go.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_iden_vm_resource_health" {
  name                = "alert-sub-tricor-identity-vm-resource-health"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-monitor-01.name
  scopes              = ["/subscriptions/${data.terraform_remote_state.subscriptions.outputs.subscription-identity-id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Virtual machine."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.Compute/virtualMachines"
  }

  action {
    action_group_id = azurerm_monitor_action_group.action_group_email_cloud_infra_go.id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}