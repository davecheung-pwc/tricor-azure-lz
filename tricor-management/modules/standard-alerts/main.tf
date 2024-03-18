locals {
  is_prod = length(regexall("-pd", var.subscription_name)) > 0 ? 1 : 0
}

# Action Group for alerts
resource "azurerm_monitor_activity_log_alert" "alert_service_health" {
  name                = "alert-${var.subscription_name}-service-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ServiceHealth event occurs."

  criteria {
    category       = "ServiceHealth"
    service_health {
      locations = var.locations
    }
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alert for Azure VM

resource "azurerm_monitor_metric_alert" "alert_vm_cpu" {
  for_each = toset(var.locations)

  name                 = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-vm-cpu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description          = "Action will be triggered when VM Percentage CPU is greater than 90%."
  target_resource_type = "Microsoft.Compute/virtualMachines"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_vm_data_disk" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-vm-data-disk"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when VM Data Disk IOPS Consumed Percentage is greater than 90 %."
  target_resource_type = "Microsoft.Compute/virtualMachines"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Data Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_vm_os_disk" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-vm-os-disk"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when VM OS Disk IOPS Consumed Percentage is greater than 90 %."
  target_resource_type = "Microsoft.Compute/virtualMachines"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "OS Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alert for Azure SQL Database

resource "azurerm_monitor_metric_alert" "alert_sql_cpu" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-cpu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when Azure SQL Database CPU Percentage is greater than 90 %."
  target_resource_type = "Microsoft.Sql/servers/databases"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_dtu" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-dtu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when Azure SQL Database DTU Percentage is greater than 90 %."
  target_resource_type = "Microsoft.Sql/servers/databases"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "dtu_consumption_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_data_io" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-data-io"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when Azure SQL Database Data IO percentage is greater than 90 %."
  target_resource_type = "Microsoft.Sql/servers/databases"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "physical_data_read_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_data_space_used" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-data-space-used"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when Azure SQL Database Data space used percent is greater than 90 %."
  target_resource_type = "Microsoft.Sql/servers/databases"
  target_resource_location = each.key
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "storage_percent"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alert for Azure SQL Database Elastic Pool

resource "azurerm_monitor_metric_alert" "alert_sql_ep_cpu" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-ep-cpu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Sql/servers/elasticpools"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure SQL Database Elastic Pool CPU Percentage is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/elasticpools"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_ep_dtu" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-ep-dtu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Sql/servers/elasticpools"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure SQL Database Elastic Pool DTU Percentage is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/elasticpools"
    metric_name      = "dtu_consumption_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_ep_data_io" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-ep-data-io"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Sql/servers/elasticpools"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure SQL Database Data Elastic Pool IO percentage is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/elasticpools"
    metric_name      = "physical_data_read_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_sql_ep_data_space_used" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-sql-ep-data-space-used"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Sql/servers/elasticpools"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure SQL Database Data Elastic Pool space used percent is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/elasticpools"
    metric_name      = "storage_percent"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alert for Key Vault
resource "azurerm_monitor_metric_alert" "alert_key_vault_availability" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-key-vault-availability"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.KeyVault/vaults"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure Key Vault request availability is less than 100 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_key_vault_saturation" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-key-vault-saturation"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.KeyVault/vaults"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure Key Vault capacity used is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "SaturationShoebox"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Metric Alert for Azure Cache for Redis
resource "azurerm_monitor_metric_alert" "alert_redis_cpu" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-redis-cpu"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Cache/redis"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure Cache for Redis CPU Percentage is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "percentProcessorTime"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_redis_memory" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-redis-memory"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Cache/redis"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure Cache for Redis Used Memory Percentage is greater than 95 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "usedmemorypercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 95
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_metric_alert" "alert_redis_server_load" {
  for_each = toset(var.locations)

  name                = "alert-${var.subscription_name}-${lower(replace(each.key, "/\\s+/", ""))}-redis-server-load"
  resource_group_name  = var.resource_group_name
  scopes               = ["/subscriptions/${var.subscription_id}"]
  target_resource_type = "Microsoft.Cache/redis"
  target_resource_location = each.key
  description         = "Action will be triggered when Azure Cache for Redis Server Load is greater than 90 %."
  frequency           = "PT5M"
  window_size         = "PT30M"

  criteria {
    metric_namespace = "Microsoft.Cache/redis"
    metric_name      = "serverLoad"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Resource Health Alerts
resource "azurerm_monitor_activity_log_alert" "alert_vm_resource_health" {
  count               = local.is_prod
  name                = "alert-${var.subscription_name}-vm-resource-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Virtual machine."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.Compute/virtualMachines"
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_aks_resource_health" {
  count               = local.is_prod
  name                = "alert-${var.subscription_name}-aks-resource-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Kubernetes service."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.ContainerService/managedClusters"
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_web_resource_health" {
  count               = local.is_prod
  name                = "alert-${var.subscription_name}-web-resource-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Web App."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.Web/sites"
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_appgw_resource_health" {
  count               = local.is_prod
  name                = "alert-${var.subscription_name}-appgw-resource-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for Application gateways."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.network/applicationgateways"
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "alert_sql_resource_health" {
  count               = local.is_prod
  name                = "alert-${var.subscription_name}-sql-resource-health"
  resource_group_name = var.resource_group_name
  scopes              = ["/subscriptions/${var.subscription_id}"]
  description         = "Action will be triggered when ResourceHealth event occurs for SQL databases."

  criteria {
    category      = "ResourceHealth"
    resource_type = "Microsoft.SQL/servers/databases"
  }

  action {
    action_group_id = var.action_group_id
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}