# Virtual Hub

output "vhub-eas-id" {
  value       = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.id
  description = "ID of Virtual Hub - EAS"
}

output "vhub-sea-id" {
  value       = azurerm_virtual_hub.vhub-go-sea-pd-conn-01.id
  description = "ID of Virtual Hub - SEA"
}

output "vhub-jpe-id" {
  value       = azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.id
  description = "ID of Virtual Hub - JPE"
}

output "vhub-jpw-id" {
  value       = azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.id
  description = "ID of Virtual Hub - JPW"
}

output "vhub-eas-name" {
  value       = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.name
  description = "Name of Virtual Hub - EAS"
}

output "vhub-sea-name" {
  value       = azurerm_virtual_hub.vhub-go-sea-pd-conn-01.name
  description = "Name of Virtual Hub - SEA"
}

output "vhub-jpe-name" {
  value       = azurerm_virtual_hub.vhub-go-jpe-pd-conn-01.name
  description = "Name of Virtual Hub - JPE"
}

output "vhub-jpw-name" {
  value       = azurerm_virtual_hub.vhub-go-jpw-pd-conn-01.name
  description = "Name of Virtual Hub - JPW"
}

output "vnet-connnet-eas-id" {
  value       = azurerm_virtual_network.connectivityvnet-eas.id
  description = "ID of Connectivity VNet - EAS"
}

output "vnet-connnet-sea-id" {
  value       = azurerm_virtual_network.connectivityvnet-sea.id
  description = "ID of Connectivity VNet - SEA"
}

output "vnet-connnet-jpe-id" {
  value       = azurerm_virtual_network.connectivityvnet-jpe.id
  description = "ID of Connectivity VNet - JPE"
}

output "vnet-connnet-jpw-id" {
  value       = azurerm_virtual_network.connectivityvnet-jpw.id
  description = "ID of Connectivity VNet - JPW"
}

output "vnet-connnet-eas-name" {
  value       = azurerm_virtual_network.connectivityvnet-eas.name
  description = "Name of Connectivity VNet - EAS"
}

output "vnet-connnet-sea-name" {
  value       = azurerm_virtual_network.connectivityvnet-sea.name
  description = "Name of Connectivity VNet - SEA"
}

output "vnet-connnet-jpe-name" {
  value       = azurerm_virtual_network.connectivityvnet-jpe.name
  description = "Name of Connectivity VNet - JPE"
}

output "vnet-connnet-jpw-name" {
  value       = azurerm_virtual_network.connectivityvnet-jpw.name
  description = "Name of Connectivity VNet - JPW"
}

output "rg-connnet-eas-name" {
  value       = azurerm_resource_group.rg-go-eas-pd-connnet-01.name
  description = "Name of Connectivity VNet RG - EAS"
}

output "rg-connnet-sea-name" {
  value       = azurerm_resource_group.rg-go-sea-pd-connnet-01.name
  description = "Name of Connectivity VNet RG - SEA"
}

output "rg-connnet-jpe-name" {
  value       = azurerm_resource_group.rg-go-jpe-pd-connnet-01.name
  description = "Name of Connectivity VNet RG - JPE"
}

output "rg-connnet-jpw-name" {
  value       = azurerm_resource_group.rg-go-jpw-pd-connnet-01.name
  description = "Name of Connectivity VNet RG - JPW"
}

output "private_dns_zone_pl_blob" {
  value       = azurerm_private_dns_zone.private_dns_zone_pl_blob
  description = "Private DNS Zone - Blob"
}