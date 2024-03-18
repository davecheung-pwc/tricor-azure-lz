output "nsg" {
    value = {
        id = azurerm_network_security_group.nsg.id
        subscription_id = data.azurerm_client_config.current.subscription_id
        resource_group_name = azurerm_network_security_group.nsg.resource_group_name
        name = azurerm_network_security_group.nsg.name
        location = azurerm_network_security_group.nsg.location
    }
}