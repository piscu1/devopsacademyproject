resource "azurerm_service_plan" "sp" {
  name                = var.app_service_plan_cont_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku
}

resource "azurerm_application_insights" "ai" {
  name                = "${var.web_app_cont_name}-ai"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

resource "azurerm_linux_web_app" "wa" {
  name                = var.web_app_cont_name
  resource_group_name = var.resource_group_name
  location            = azurerm_service_plan.sp.location
  service_plan_id     = azurerm_service_plan.sp.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name        = var.container_image_name
      docker_registry_url      = var.container_registry_url
      docker_registry_username = var.container_username
      docker_registry_password = var.container_password
    }
  }

  app_settings = {
    WEBSITES_PORT = "80"
    APPINSIGHTS_INSTRUMENTATIONKEY         = azurerm_application_insights.ai.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING  = azurerm_application_insights.ai.connection_string
  }
  
  https_only = true
}