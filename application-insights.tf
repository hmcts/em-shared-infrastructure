
// Need to create new AppInsights in the UK South region only, as per the requirement.

module "application_insights" {
  source = "git@github.com:hmcts/terraform-module-application-insights?ref=4.x"

  env     = var.env
  product = var.product
  name    = "em"

  resource_group_name = azurerm_resource_group.rg.name

  common_tags = local.tags
}

moved {
  from = azurerm_application_insights.em_appinsights
  to   = module.application_insights.azurerm_application_insights.this
}
resource "azurerm_key_vault_secret" "em_app_insights_connection_string" {
  name         = "em-app-insights-connection-string"
  value        = module.application_insights.connection_string
  key_vault_id = module.key_vault.key_vault_id
}

resource "azurerm_key_vault_secret" "em_app_insights_key" {
  name         = "EmAppInsightsInstrumentationKey"
  value        = module.application_insights.instrumentation_key
  key_vault_id = module.key_vault.key_vault_id
}

output "em_appInsightsInstrumentationKey" {
  sensitive = true
  value     = module.application_insights.instrumentation_key
}
