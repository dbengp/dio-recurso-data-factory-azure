output "resource_group_name" {
  description = "Nome do Grupo de Recursos criado."
  value       = azurerm_resource_group.rg.name
}

output "data_factory_url" {
  description = "URL para acessar o Azure Data Factory no Portal do Azure."
  value       = "https://portal.azure.com/#@/resource${azurerm_data_factory.adf.id}/overview"
}

output "storage_account_primary_blob_endpoint" {
  description = "Endpoint primário de blob da conta de armazenamento."
  value       = azurerm_storage_account.adl_storage.primary_blob_endpoint
}
