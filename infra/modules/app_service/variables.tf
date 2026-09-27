variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure location for resources"
  default     = "West Europe"
}

variable "app_service_plan_name" {
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

