# Azure Private DNS Resolver - EAS
resource "azurerm_private_dns_resolver" "resolver_eas" {
  name                = "dnspr-go-eas-pd-dns-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-dns-01.location
  virtual_network_id  = azurerm_virtual_network.connectivityvnet-eas.id

  tags = {
    "ApplicationId"       = "dns"
    "ApplicationName"     = "Private DNS"
    "ApplicationOwner"    = "TBC"
    "BusinessCriticality" = "Standard"
    "BusinessUnit"        = "IT"
    "CostCenter"          = "TBC"
    "DataClassification"  = "Restricted"
    "Environment"         = "PROD"
    "Site"                = "GO"
  }
}

# Azure Private DNS Resolver Inbound Endpoint - EAS
resource "azurerm_private_dns_resolver_inbound_endpoint" "resolver_eas_inbound_endpoint" {
  name                    = "dnspr-go-eas-pd-dns-01-inbound-endpoint"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver_eas.id
  location                = azurerm_private_dns_resolver.resolver_eas.location

  ip_configurations {
    private_ip_allocation_method = "Dynamic" # Dynamic is default and only supported.
    subnet_id                    = azurerm_subnet.connectivitysubnet-eas-dns-in.id
  }

  tags = {
    "ApplicationId"       = "dns"
    "ApplicationName"     = "Private DNS"
    "ApplicationOwner"    = "TBC"
    "BusinessCriticality" = "Standard"
    "BusinessUnit"        = "IT"
    "CostCenter"          = "TBC"
    "DataClassification"  = "Restricted"
    "Environment"         = "PROD"
    "Site"                = "GO"
  }
}
