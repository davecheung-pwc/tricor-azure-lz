output "loganalyticsworkspace-log-eas-id" {
  value       = azurerm_log_analytics_workspace.log-eas.id
  description = "ID of Log Analytics Workspace for EAS"
}

output "loganalyticsworkspace-log-sea-id" {
  value       = azurerm_log_analytics_workspace.log-sea.id
  description = "ID of Log Analytics Workspace for SEA"
}

output "loganalyticsworkspace-log-jpe-id" {
  value       = azurerm_log_analytics_workspace.log-jpe.id
  description = "ID of Log Analytics Workspace for JPE"
}

output "loganalyticsworkspace-log-jpw-id" {
  value       = azurerm_log_analytics_workspace.log-jpw.id
  description = "ID of Log Analytics Workspace for JPW"
}