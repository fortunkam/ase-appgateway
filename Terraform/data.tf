data "azurerm_client_config" "current" {
}
data "azurerm_subscription" "primary" {
}

data "azurerm_app_service_environment" "ase" {
  name                   = local.ase_name
resource_group_name     = azurerm_resource_group.spoke.name
depends_on = [azurerm_template_deployment.deployASE]
}

data "azurerm_storage_account_blob_container_sas" "scripts" {
  connection_string = azurerm_storage_account.deploy.primary_connection_string
  container_name    = azurerm_storage_container.scripts.name
  https_only        = true

  start  = "${timestamp()}"
  expiry = "${timeadd(timestamp(), "1h")}"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}

data "local_file" "ase_ip" {
    filename = "${path.module}/ase_ip.txt"
}