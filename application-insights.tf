resource "azurerm_application_insights" "appinsights" {
  name                = "${var.product}-${var.env}"
  location            = var.appinsights_location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = var.application_type
}

resource "azurerm_key_vault_secret" "app_insights_connection_string" {
  name         = "app-insights-connection-string"
  value        = azurerm_application_insights.appinsights.connection_string
  key_vault_id = module.key_vault.key_vault_id
}
  
output "appInsightsInstrumentationKey" {
  sensitive = true
  value = azurerm_application_insights.appinsights.instrumentation_key
}

// Need to create new AppInsights in the UK South region only, as per the requirement.

resource "azurerm_application_insights" "em_appinsights" {
  name                = "em-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = var.application_type
}

resource "azurerm_key_vault_secret" "em_app_insights_connection_string" {
  name         = "em-app-insights-connection-string"
  value        = azurerm_application_insights.em_appinsights.connection_string
  key_vault_id = module.key_vault.key_vault_id
}

output "em_appInsightsInstrumentationKey" {
  value = azurerm_application_insights.em_appinsights.instrumentation_key
}
