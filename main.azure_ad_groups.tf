data "azuread_client_config" "current" {}

resource "azuread_group" "group-cloud-infrastructure-team" {
  display_name     = "group-cloud-infrastructure-team"
  description      = "Cloud Infrastructure Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-cloud-infrastructure-team-pid" {
  display_name     = "group-cloud-infrastructure-team-pid"
  description      = "Cloud Infrastructure Team - PID"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-hk-infrastructure-team" {
  display_name     = "group-hk-infrastructure-team"
  description      = "Hong Kong Infrastructure Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-hk-infrastructure-team-pid" {
  display_name     = "group-hk-infrastructure-team-pid"
  description      = "Hong Kong Infrastructure Team - PID"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-go-infrastructure-team" {
  display_name     = "group-go-infrastructure-team"
  description      = "Group Office Infrastructure Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-go-infrastructure-team-pid" {
  display_name     = "group-go-infrastructure-team-pid"
  description      = "Group Office Infrastructure Team - PID"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-app-team-issuer-portal" {
  display_name     = "group-app-team-issuer-portal"
  description      = "Issuer Portal Application Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-security-team" {
  display_name     = "group-security-team"
  description      = "Security Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-noc-team" {
  display_name     = "group-noc-team"
  description      = "NOC Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group" "group-helpdesk-team" {
  display_name     = "group-helpdesk-team"
  description      = "Helpdesk Team"
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}