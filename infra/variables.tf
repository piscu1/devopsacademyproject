
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "object_id" {
  description = "Azure Object ID"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
  default     = "RG-alexandru-pisculungeanu"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], lower(var.environment))
    error_message = "Environment must be 'dev' or 'prod'."
  }
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "app_service_plan_cont_name" {
  type        = string
  description = "Name of the App Service Plan"
}

variable "app_service_plan_sku" {
  type        = string
  description = "SKU of the App Service Plan"
  default     = "B1"
}

variable "web_app_name" {
  type        = string
  description = "Name of the Web App"
}

variable "web_app_cont_name" {
  type        = string
  description = "Name of the Web App"
}

variable "container_image_name" {
  type        = string
  description = "Container image to run"
}

variable "container_registry_url" {
  type        = string
  description = "URL of the container registry"
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "container_username" {
  description = "Name for the AcrPull token used in webapp permissions"
  type        = string
}

variable "container_password" {
  description = "Password for the AcrPull token used in webapp permissions"
  type        = string
}