############################################
#region Virtual Hub VPN - EAS
############################################

resource "azurerm_vpn_gateway" "vpngw-go-eas-pd-conn-01" {
  provider            = azurerm.connectivity
  name                = format("%s-%s-%s-%s", "vgw", azurerm_virtual_hub.vhub-go-eas-pd-conn-01.name, "vpn", "01")
  location            = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.location
  resource_group_name = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.resource_group_name
  virtual_hub_id      = azurerm_virtual_hub.vhub-go-eas-pd-conn-01.id
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

############################################
#endregion Virtual Hub VPN - EAS
############################################