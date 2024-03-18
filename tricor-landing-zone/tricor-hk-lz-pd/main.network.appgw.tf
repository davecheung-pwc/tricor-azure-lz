locals {
  application_gateway_name = "appgw-hk-eas-pd-shared-01"
}

resource "azurerm_application_gateway" "lzappgw-hk-pd-eas" {
  provider            = azurerm.landingzone_hk_pd
  name                = local.application_gateway_name
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-appgw-01.name
  location            = azurerm_resource_group.rg-hk-eas-pd-appgw-01.location
  zones               = [1, 2, 3]

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }

  gateway_ip_configuration {
    name      = "${local.application_gateway_name}-ipconfig-01"
    subnet_id = azurerm_subnet.lzsubnet-hk-pd-eas-appgw.id
  }

  frontend_ip_configuration {
    name                 = "${local.application_gateway_name}-feip-public"
    public_ip_address_id = azurerm_public_ip.pip-appgw-hk-pd-eas.id
  }

  frontend_port {
    name = "${local.application_gateway_name}-feport-http"
    port = 80
  }

  frontend_port {
    name = "${local.application_gateway_name}-feport-https"
    port = 443
  }

  backend_address_pool {
    name = "pool-www.example.com"
  }

  backend_http_settings {
    name                  = "http-www.example.com"
    cookie_based_affinity = "Enabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-www.example.com"
    frontend_ip_configuration_name = "${local.application_gateway_name}-feip-public"
    frontend_port_name             = "${local.application_gateway_name}-feport-http"
    protocol                       = "Http"
  }

  probe {
    host                                      = "www.example.com"
    interval                                  = 30
    minimum_servers                           = 0
    name                                      = "http-www.example.com"
    path                                      = "/"
    pick_host_name_from_backend_http_settings = false

    protocol            = "Http"
    timeout             = 30
    unhealthy_threshold = 3
    match {
      status_code = ["200-399"]
    }
  }

  request_routing_rule {
    priority                   = 10
    name                       = "rule-http-www.example.com-01"
    rule_type                  = "Basic"
    http_listener_name         = "http-www.example.com"
    backend_address_pool_name  = "pool-www.example.com"
    backend_http_settings_name = "http-www.example.com"
  }

  lifecycle {
    ignore_changes = [
      frontend_port,
      backend_address_pool,
      backend_http_settings,
      http_listener,
      ssl_certificate,
      trusted_root_certificate,
      probe,
      request_routing_rule
    ]
  }
}

resource "azurerm_public_ip" "pip-appgw-hk-pd-eas" {
  provider            = azurerm.landingzone_hk_pd
  name                = "${local.application_gateway_name}-pip01"
  resource_group_name = azurerm_resource_group.rg-hk-eas-pd-appgw-01.name
  location            = azurerm_resource_group.rg-hk-eas-pd-appgw-01.location
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Standard"
  zones               = [1, 2, 3]
}
