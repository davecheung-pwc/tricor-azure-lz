terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.44.1"
    }
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "nsg" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = length(var.nsg_name) > 0 ? var.nsg_name : "nsg-${var.subnet.name}"
  resource_group_name = data.azurerm_resource_group.nsg.name
  location            = length(var.location) > 0 ? var.location : data.azurerm_resource_group.nsg.location
  tags                = length(var.tags) > 0 ? var.tags : data.azurerm_resource_group.nsg.tags
  depends_on          = [var.module_depends_on]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = var.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "rule_baseline_allow_icmp" {
  name                        = "iba-baseline-icmp"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Icmp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rule_baseline_allow_lb" {
  name                        = "iba-baseline-loadbalancer"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "AzureLoadBalancer"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rule_baseline_allow_mgmtsubnet" {
  name                        = "iba-baseline-mgmtsubnet"
  priority                    = 500
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = var.management_subnet_address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rule_baseline_deny_blockedservice" {
  name                        = "ibd-baseline-deny-blockedservice"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_ranges     = [22, 135, 139, 445, 3389]
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rule_baseline_allow_samesubnet" {
  count                       = var.allow_samesubnet ? 1 : 0
  name                        = "iba-baseline-samesubnet"
  priority                    = 2000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = var.subnet.address_prefixes
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rule_baseline_deny_all" {
  name                        = "ibd-baseline-deny-all"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.nsg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
