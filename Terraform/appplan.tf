resource "azurerm_app_service_plan" "appplan" {
  name                = local.appplan_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name

  sku {
    tier = "Isolated"
    size = "I1"
    capacity = 1
  }

  app_service_environment_id = data.azurerm_app_service_environment.ase.id

  depends_on = [azurerm_template_deployment.deployASE]

  lifecycle {
        ignore_changes = [ "app_service_environment_id" ]
    }

}