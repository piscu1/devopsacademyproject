variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure location for resources"
  default     = "West Europe"
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

variable "container_username" {
  description = "Name for the AcrPull token used in webapp permissions"
  type        = string
}

variable "container_password" {
  description = "Password for the AcrPull token used in webapp permissions"
  type        = string
}