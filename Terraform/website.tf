resource "azurerm_app_service" "website" {
  name                = local.website_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  app_service_plan_id = azurerm_app_service_plan.appplan.id
}