# resource "azurerm_app_service_environment" "ase" {
#   name                   = local.ase_name
#   subnet_id              = azurerm_subnet.ase.id
#   pricing_tier           = "I1"
# }

resource "azurerm_template_deployment" "deployASE" {
    name            = "deployASE1"
    resource_group_name = azurerm_resource_group.spoke.name
    template_body = file("${path.module}/ARM/ase.json")
     parameters = {
        "name" = local.ase_name
        "subnetId" = azurerm_subnet.ase.id
    }
    deployment_mode = "Incremental"
    lifecycle {
        ignore_changes = all
    }
}

resource "null_resource" "getASEIP" {
    depends_on = [azurerm_template_deployment.deployASE]
    provisioner "local-exec" {
        command = "az resource show --ids '/subscriptions/${data.azurerm_subscription.primary.subscription_id}/resourceGroups/${azurerm_resource_group.spoke.name}/providers/Microsoft.Web/hostingEnvironments/${local.ase_name}/capacities/virtualip' --query 'internalIpAddress' -o tsv | Out-File -encoding UTF8 ase_ip.txt"
        interpreter = ["PowerShell", "-Command"]
    }
}