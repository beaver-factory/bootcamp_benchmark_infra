
resource "azurerm_storage_account" "storage_acc" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = {
    displayName = var.storage_account_name
  }
}

resource "azurerm_storage_container" "container1" {
  name                  = var.blob_container1
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "container2" {
  name                  = var.blob_container2
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "container3" {
  name                  = var.blob_container3
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "blob"
}
