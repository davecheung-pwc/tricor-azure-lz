resource "azurerm_private_endpoint" "pep-storageaccount-veeam-eas" {
  provider                      = azurerm.management
  name                          = "pep-sagoeaspdveeam01"
  location                      = azurerm_resource_group.rg-go-eas-pd-veeam-01.location
  resource_group_name           = azurerm_resource_group.rg-go-eas-pd-veeam-01.name
  subnet_id                     = azurerm_subnet.managementsubnet-eas-veeam.id
  custom_network_interface_name = "pep-sagoeaspdveeam01-nic01"

  private_service_connection {
    name                           = "psc-sagoeaspdveeam01"
    private_connection_resource_id = azurerm_storage_account.storageaccount-veeam-eas.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["/subscriptions/d7289b80-6ddc-46a3-a9d0-35cb7499b95e/resourceGroups/rg-go-eas-pd-dns-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_a_record" "dns_pep_sagoeaspdveeam01" {
  provider            = azurerm.connectivity
  name                = "sagoeaspdveeam01"
  zone_name           = data.terraform_remote_state.connectivity.outputs.private_dns_zone_pl_blob.name
  resource_group_name = data.terraform_remote_state.connectivity.outputs.private_dns_zone_pl_blob.resource_group_name
  ttl                 = 10
  records             = [azurerm_private_endpoint.pep-storageaccount-veeam-eas.private_service_connection.0.private_ip_address]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# resource "azurerm_private_endpoint" "pep-storageaccount-veeam-sea" {
#   name                          = "pep-sagoseapdveeam01"
#   location                      = azurerm_resource_group.rg-go-sea-pd-veeam-01.location
#   resource_group_name           = azurerm_resource_group.rg-go-sea-pd-veeam-01.name
#   subnet_id                     = azurerm_subnet.managementsubnet-sea-veeam.id
#   custom_network_interface_name = "pep-sagoseapdveeam01-nic01"

#   private_service_connection {
#     name                           = "psc-sagoseapdveeam01"
#     private_connection_resource_id = azurerm_storage_account.storageaccount-veeam-sea.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }
# }

# resource "azurerm_private_endpoint" "pep-storageaccount-veeam-jpe" {
#   name                          = "pep-sagojpepdveeam01"
#   location                      = azurerm_resource_group.rg-go-jpe-pd-veeam-01.location
#   resource_group_name           = azurerm_resource_group.rg-go-jpe-pd-veeam-01.name
#   subnet_id                     = azurerm_subnet.managementsubnet-jpe-veeam.id
#   custom_network_interface_name = "pep-sagojpepdveeam01-nic01"

#   private_service_connection {
#     name                           = "psc-sagojpepdveeam01"
#     private_connection_resource_id = azurerm_storage_account.storageaccount-veeam-jpe.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }
# }

# resource "azurerm_private_endpoint" "pep-storageaccount-veeam-jpw" {
#   name                          = "pep-sagojpwpdveeam01"
#   location                      = azurerm_resource_group.rg-go-jpw-pd-veeam-01.location
#   resource_group_name           = azurerm_resource_group.rg-go-jpw-pd-veeam-01.name
#   subnet_id                     = azurerm_subnet.managementsubnet-jpw-veeam.id
#   custom_network_interface_name = "pep-sagojpwpdveeam01-nic01"

#   private_service_connection {
#     name                           = "psc-sagojpwpdveeam01"
#     private_connection_resource_id = azurerm_storage_account.storageaccount-veeam-jpw.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }
# }