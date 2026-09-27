resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  sku_name                   = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["Get","List","Set","Delete","Recover","Purge"]
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    secret_permissions = ["Get","List","Set","Delete","Recover","Purge"]
  }
  
}

data "azurerm_client_config" "current" {}