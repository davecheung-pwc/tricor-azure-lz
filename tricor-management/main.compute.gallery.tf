resource "azurerm_shared_image_gallery" "computegallery-eas" {
  name                = "gal_go_eas_pd_vmimg_01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-vmimg-01.name
  location            = azurerm_resource_group.rg-go-eas-pd-vmimg-01.location
  description         = "Shared images for Tricor Group"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}