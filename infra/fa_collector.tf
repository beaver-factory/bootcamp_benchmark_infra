resource "azurerm_linux_function_app" "collectors" {
  name                       = var.collectors_fa_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = var.resource_group_name
  storage_account_name       = azurerm_storage_account.storage_acc.name
  storage_account_access_key = azurerm_storage_account.storage_acc.primary_access_key
  service_plan_id            = azurerm_service_plan.fasp.id

  depends_on = [
    azurerm_application_insights.fa_insights,
    azurerm_service_plan.fasp,
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
  }
  app_settings = {
    "AzureWebJobsDashboard"                    = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${azurerm_storage_account.storage_acc.primary_access_key}"
    "AzureWebJobsStorage"                      = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${azurerm_storage_account.storage_acc.primary_access_key}"
    "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account_name};AccountKey=${azurerm_storage_account.storage_acc.primary_access_key}"
    "WEBSITE_CONTENTSHARE"                     = lower(var.collectors_fa_name)
    "FUNCTIONS_EXTENSION_VERSION"              = "~4"
    "APPINSIGHTS_INSTRUMENTATIONKEY"           = azurerm_application_insights.fa_insights.instrumentation_key
    "FUNCTIONS_WORKER_RUNTIME"                 = "python"
    "FUNCTIONS_WORKER_RUNTIME_VERSION"         = "3.8"
    "ResourceGroupName"                        = var.resource_group_name
    "BlobContainer1"                           = var.blob_container1
    "BlobContainer2"                           = var.blob_container2
    "BlobContainer3"                           = var.blob_container3
    "KeyVaultName"                             = var.keyvault_name
  }
}
