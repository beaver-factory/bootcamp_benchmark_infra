resource "azurerm_linux_function_app" "processors" {
  name                        = var.processors_fa_name
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = var.resource_group_name
  storage_account_name        = azurerm_storage_account.storage_acc.name
  storage_account_access_key  = azurerm_storage_account.storage_acc.primary_access_key
  service_plan_id             = azurerm_service_plan.service_plan.id
  functions_extension_version = "~4"

  depends_on = [
    azurerm_application_insights.fa_insights,
    azurerm_service_plan.service_plan,
    azurerm_storage_account.storage_acc,
  ]

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = "3.8"
    }

    cors {
      allowed_origins = ["https://portal.azure.com"]
    }

    application_insights_key = azurerm_application_insights.fa_insights.instrumentation_key
    application_insights_connection_string = azurerm_application_insights.fa_insights.connection_string
  }

  app_settings = {
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = azurerm_storage_account.storage_acc.primary_connection_string
    "WEBSITE_CONTENTSHARE"                     = lower(var.processors_fa_name)
    "ResourceGroupName"                        = var.resource_group_name
    "BlobContainer1"                           = var.blob_container1
    "BlobContainer2"                           = var.blob_container2
    "BlobContainer3"                           = var.blob_container3
    "KeyVaultName"                             = var.keyvault_name
  }
}



data "azurerm_linux_function_app" "processors" {
  name                = var.processors_fa_name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [ azurerm_linux_function_app.processors ]
}

