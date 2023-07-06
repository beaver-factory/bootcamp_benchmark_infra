output "storageaccountname" {
  value = azurerm_storage_account.storage_acc.name
}

output "utilstoragecontainername" {
  value = azurerm_storage_container.container3.name
}