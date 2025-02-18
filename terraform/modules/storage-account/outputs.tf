output "id" {
  value = azurerm_storage_account.account.id
  description = "Value of the storage account ID"
}

output "sa_name" {
  value = azurerm_storage_account.account.name
  description = "Name of the storage account"
}

output "container_name" {
  value = azurerm_storage_container.container.name
  description = "Name of the storage account"
}