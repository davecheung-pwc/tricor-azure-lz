resource "azurerm_resource_group" "rg-go-eas-pd-policy-01" {
  provider = azurerm.management
  name     = "rg-go-eas-pd-policy-01"
  location = "East Asia"
  tags = {
    Site                = "GO"
    BusinessUnit        = "IT"
    ApplicationName     = "Azure Policy"
    ApplicationId       = "policy"
    CostCenter          = "TBC"
    ApplicationOwner    = "TBC"
    Environment         = "PROD"
    DataClassification  = "Restricted"
    BusinessCriticality = "Standard"
  }
}

resource "azurerm_user_assigned_identity" "id-go-eas-pd-policy-01" {
  location            = azurerm_resource_group.rg-go-eas-pd-policy-01.location
  name                = "id-go-eas-pd-policy-01"
  resource_group_name = azurerm_resource_group.rg-go-eas-pd-policy-01.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_management_group.lz_root_management_group.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.id-go-eas-pd-policy-01.principal_id
}

## Mandate tags from resource group (To be enabled after landing zone deployment is completed)

resource "azurerm_management_group_policy_assignment" "mandate_site_tag" {
  name                 = "mandate-site-tag"
  display_name         = "Resource Group must contain Site tag"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "Site"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mandate_business_unit_tag" {
  name                 = "mandate-bu-tag"
  display_name         = "Resource Group must contain BusinessUnit tag"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "BusinessUnit"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mandate_application_name_tag" {
  name                 = "mandate-appname-tag"
  display_name         = "Resource Group must contain ApplicationName tag"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "ApplicationName"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mandate_application_owner_tag" {
  name                 = "mandate-appowner-tag"
  display_name         = "Resource Group must contain ApplicationOwner tag"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "ApplicationOwner"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mandate_environment_tag" {
  name                 = "mandate-environment-tag"
  display_name         = "Resource Group must contain Environment tag"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

## Inherit tags from subscription or resource group

resource "azurerm_management_group_policy_assignment" "inherit_site_tag" {
  name                 = "inherit-site-tag"
  display_name         = "Inherit Site tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "Site"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_env_tag" {
  name                 = "inherit_env_tag"
  display_name         = "Inherit Environment tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "Environment"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_bu_tag" {
  name                 = "inherit_bu_tag"
  display_name         = "Inherit BusinessUnit tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "BusinessUnit"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_appname_tag" {
  name                 = "inherit_appname_tag"
  display_name         = "Inherit ApplicationName tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "ApplicationName"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_appid_tag" {
  name                 = "inherit_appid_tag"
  display_name         = "Inherit ApplicationId tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "ApplicationId"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_costcenter_tag" {
  name                 = "inherit_costcenter_tag"
  display_name         = "Inherit CostCenter tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "CostCenter"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_appowner_tag" {
  name                 = "inherit_appowner_tag"
  display_name         = "Inherit ApplicationOwner tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "ApplicationOwner"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_dataclass_tag" {
  name                 = "inherit_dataclass_tag"
  display_name         = "Inherit DataClassification tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "DataClassification"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "inherit_criticality_tag" {
  name                 = "inherit_criticality_tag"
  display_name         = "Inherit BusinessCriticality tag from the resource group if missing"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ea3f2387-9b95-492a-a190-fcdc54f7b070"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    tagName = {
      value = "BusinessCriticality"
    }
  })
}

# Enforce minimum TLS version for encryption in transit

resource "azurerm_management_group_policy_assignment" "min_tls_sql" {
  name                 = "min_tls_sql"
  display_name         = "Azure SQL Database should be running TLS version 1.2 or newer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/32e6bbec-16b6-44c2-be37-c5b672d103cf"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "min_tls_sql_mi" {
  name                 = "min_tls_sql_mi"
  display_name         = "Azure SQL Managed Instance should be running TLS version 1.2 or newer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a8793640-60f7-487c-b5c3-1d37215905c4"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Audit"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "min_tls_storage_account" {
  name                 = "min_tls_storage_account"
  display_name         = "Azure Storage Account should be running TLS version 1.2 or newer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fe83a0eb-a853-422d-aac2-1bffd182c5d0"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
    minimumTlsVersion = {
      value = "TLS1_2"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "min_tls_function" {
  name                 = "min_tls_function"
  display_name         = "Function App should be running TLS version 1.2 or newer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f01f1c7-539c-49b5-9ef4-d4ffa37d22e0"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "min_tls_app_service" {
  name                 = "min_tls_app_service"
  display_name         = "App Service should be running TLS version 1.2 or newer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ae44c1d1-0df2-4ca9-98fa-a3d3ae5b409d"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }
  })
}

## Enforce Encryption At Rest
resource "azurerm_management_group_policy_assignment" "encrypt_sql" {
  name                 = "encrypt_sql"
  display_name         = "Transparent Data Encryption on SQL databases should be enabled"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86a912f6-9a06-4e26-b447-11b16ba8659f"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "DeployIfNotExists"
    }
  })
}

# Disable public network access
resource "azurerm_management_group_policy_assignment" "disable_public_redis" {
  name                 = "disable_public_redis"
  display_name         = "Azure Cache for Redis should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/470baccb-7e51-4549-8b1a-3e5be069f663"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_keyvault" {
  name                 = "disable_public_keyvault"
  display_name         = "Azure Key Vault should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/405c5871-3e91-4644-8a63-58e19d68ff5b"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_sql" {
  name                 = "disable_public_sql"
  display_name         = "Azure SQL Server should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Audit" # Audit because Azure SQL can't disable public network access during creation
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_sql_mi" {
  name                 = "disable_public_sql_mi"
  display_name         = "Azure SQL Managed Instances should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9dfea752-dd46-4766-aed1-c355fa93fb91"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_postgrefs" {
  name                 = "disable_public_postgrefs"
  display_name         = "PostgreSQL flexible servers should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5e1de0e3-42cb-4ebc-a86d-61d0c619ca48"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_postgre" {
  name                 = "disable_public_postgre"
  display_name         = "PostgreSQL servers should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b52376f7-9612-48a1-81cd-1ffe4b61032c"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Audit" # Audit because PostgreSQL servers can't disable public network access during creation
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_mysqlfs" {
  name                 = "disable_public_mysqlfs"
  display_name         = "MySQL flexible servers should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9299215-ae47-4f50-9c54-8a392f68a052"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_mariadb" {
  name                 = "disable_public_mariadb"
  display_name         = "MariaDB servers should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fdccbe47-f3e3-4213-ad5d-ea459b2fa077"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_cosmos_db" {
  name                 = "disable_public_cosmos_db"
  display_name         = "Azure Cosmos DB should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/797b37f7-06b8-444c-b1ad-fc62867f335a"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "disable_public_storage" {
  name                 = "disable_public_storage"
  display_name         = "Storage accounts should disable public network access"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b2982f36-99f2-4db5-8eff-283140c09693"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "mandate_secure_transfer" {
  name                 = "mandate_secure_transfer"
  display_name         = "Storage accounts should enable secure transfer"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "key_vault_soft_delete" {
  name                 = "key_vault_soft_delete"
  display_name         = "Key Vaults should enable soft delete"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "key_vault_purge_protect" {
  name                 = "key_vault_purge_protect"
  display_name         = "Key Vaults should enable purge protection"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b60c0b2-2dc2-4e1c-b5c9-abbed971de53"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
  parameters = jsonencode({
    effect = {
      value = "Deny"
    }
  })
}

resource "azurerm_management_group_policy_assignment" "azure_vm_update_auto_assessment" {
  name                 = "vm_update_auto_assess"
  display_name         = "Configure periodic checking for missing system updates on azure virtual machines"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15"
  management_group_id  = azurerm_management_group.landing_zone_management_group.id
  location             = "East Asia"
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.id-go-eas-pd-policy-01.id]
  }
  parameters = jsonencode({
    locations = {
      value = ["eastasia","southeastasia","japaneast"]
    }
  })
}

# Compliance - CIS Microsoft Azure Foundations Benchmark v1.4.0
resource "azurerm_management_group_policy_assignment" "cis_azure_1_4" {
  name                 = "CIS Benchmark v1.4.0"
  display_name         = "CIS Microsoft Azure Foundations Benchmark v1.4.0 "
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/c3f5c4d9-9a1d-4a99-85c0-7f93e384d5c5"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
}

# Compliance - ISO 27001:2013
resource "azurerm_management_group_policy_assignment" "iso_27001_2013" {
  name                 = "ISO 27001 2013"
  display_name         = "ISO 27001:2013"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/89c6cddc-1c73-4ac1-b19c-54d1a15a42f2"
  management_group_id  = azurerm_management_group.lz_root_management_group.id
  location             = "East Asia"
  identity {
    type = "SystemAssigned"
  }
}