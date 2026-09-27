terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = var.subscription_id

}

data "azurerm_client_config" "current" {}

module "app_service" {
  source = "./modules/app_service"

  resource_group_name         = var.resource_group_name
  location                    = var.location
  app_service_plan_name       = var.app_service_plan_name
  app_service_plan_sku        = var.app_service_plan_sku
  web_app_name                = var.web_app_name
}

module "key_vault" {
  source = "./modules/key_vault"

  resource_group_name         = var.resource_group_name
  location                    = var.location
  tenant_id                   = var.tenant_id
  object_id                   = var.object_id
  key_vault_name              = var.key_vault_name
}

module "app_service_containerized" {
  source = "./modules/app_service_containerized"

  resource_group_name         = var.resource_group_name
  location                    = var.location
  app_service_plan_cont_name  = var.app_service_plan_cont_name
  app_service_plan_sku        = var.app_service_plan_sku
  web_app_cont_name           = var.web_app_cont_name
  container_image_name        = var.container_image_name
  container_registry_url      = var.container_registry_url
  container_username          = var.container_username
  container_password          = var.container_password
}