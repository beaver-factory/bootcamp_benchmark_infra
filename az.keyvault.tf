resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  depends_on = [ azurerm_linux_function_app.collectors, azurerm_linux_function_app.loaders, azurerm_linux_function_app.processors ]

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  # app reg
  access_policy {
    object_id = var.app_registration_sp_object_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Set"
    ]
  }

  # dev group
  access_policy {
    object_id = var.dev_group_obj_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "List",
      "Get"
    ]
  }

  # collector func
  access_policy {
    object_id = data.azurerm_linux_function_app.collectors.identity[0].principal_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get"
    ]
  }

  # processor func
  access_policy {
    object_id = data.azurerm_linux_function_app.processors.identity[0].principal_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get"
    ]
  }

  # loader func
  access_policy {
    object_id = data.azurerm_linux_function_app.loaders.identity[0].principal_id
    tenant_id = data.azurerm_client_config.current.tenant_id

    secret_permissions = [
      "Get"
    ]
  }


}

