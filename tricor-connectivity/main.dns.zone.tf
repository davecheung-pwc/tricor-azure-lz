resource "azurerm_private_dns_zone" "private_dns_zone_pl_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_blob_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_blob.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_blob_mgmtnet_eas" {
  name                  = "link-vnet-go-eas-pd-mgmtnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_blob.name
  virtual_network_id    = "/subscriptions/89854a87-cea1-4730-87df-eaad66f10d7f/resourceGroups/rg-go-eas-pd-mgmtnet-01/providers/Microsoft.Network/virtualNetworks/vnet-go-eas-pd-mgmtnet-01"
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_sql_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_sql.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_redis_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_redis.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_kv_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_kv.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_mysql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_mysql_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_mysql.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_file_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_file.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_adf" {
  name                = "privatelink.datafactory.azure.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_adf_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_adf.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_app" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_app_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_app.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_pl_acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "link_pl_acr_connnet_eas" {
  name                  = "link-vnet-go-eas-pd-connnet-01"
  resource_group_name   = azurerm_resource_group.rg-go-eas-pd-dns-01.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_pl_acr.name
  virtual_network_id    = azurerm_virtual_network.connectivityvnet-eas.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}