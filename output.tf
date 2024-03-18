# Subscriptions under Platform Management Group

output "subscription-connectivity-id" {
  value       = azurerm_subscription.connectivity.subscription_id
  description = "ID of Connectivity subscription"
}

output "subscription-management-id" {
  value       = azurerm_subscription.management.subscription_id
  description = "ID of Management subscription"
}

output "subscription-identity-id" {
  value       = azurerm_subscription.identity.subscription_id
  description = "ID of Identity subscription"
}

# Subscriptions under Landing Zone Management Group

output "subscription-landingzone_go_np-id" {
  value       = azurerm_subscription.landingzone_go_np.subscription_id
  description = "ID of landingzone_go_np subscription"
}

output "subscription-landingzone_go_pd-id" {
  value       = azurerm_subscription.landingzone_go_pd.subscription_id
  description = "ID of landingzone_go_pd subscription"
}

output "subscription-landingzone_hk_np-id" {
  value       = azurerm_subscription.landingzone_hk_np.subscription_id
  description = "ID of landingzone_hk_np subscription"
}

output "subscription-landingzone_hk_pd-id" {
  value       = azurerm_subscription.landingzone_hk_pd.subscription_id
  description = "ID of landingzone_hk_pd subscription"
}