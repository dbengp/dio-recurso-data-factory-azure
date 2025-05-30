# Configure o provedor Azure
provider "azurerm" {
  features {}
}

# 1. Grupo de Recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Conta de Armazenamento (Data Lake Storage Gen2)
resource "azurerm_storage_account" "adl_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true # Habilita Data Lake Storage Gen2
}

# 3. Conteineres / File Systems dentro do Data Lake
resource "azurerm_storage_container" "raw_data_container" {
  name                  = "rawdata"
  storage_account_name  = azurerm_storage_account.adl_storage.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "processed_data_container" {
  name                  = "processeddata"
  storage_account_name  = azurerm_storage_account.adl_storage.name
  container_access_type = "private"
}

# 4. Azure Data Factory
resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 5. Linked Service para o Data Lake Storage Gen2 no ADF
resource "azurerm_data_factory_linked_service_azure_blob_storage" "adl_linked_service" {
  name                = "ls_adls_gen2"
  resource_group_name = azurerm_resource_group.rg.name
  data_factory_name   = azurerm_data_factory.adf.name
  connection_string   = azurerm_storage_account.adl_storage.primary_connection_string
  description         = "Linked Service to Azure Data Lake Storage Gen2"
}

# 6. Dataset para os dados brutos (input)
resource "azurerm_data_factory_dataset_ delimited_text" "input_dataset" {
  name                = "ds_raw_sales_data"
  resource_group_name = azurerm_resource_group.rg.name
  data_factory_name   = azurerm_data_factory.adf.name
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.adl_linked_service.name

  azure_blob_storage_path {
    folder_path = "rawdata"
    file_path   = "sales_data.csv" # Nome do arquivo que esperamos encontrar
    container_name = azurerm_storage_container.raw_data_container.name
  }

  column_delimiter  = ","
  row_delimiter     = "\n"
  first_row_as_header = true
  encoding          = "UTF-8"
}

# 6. Dataset para os dados processados (output)
resource "azurerm_data_factory_dataset_delimited_text" "output_dataset" {
  name                = "ds_processed_sales_data"
  resource_group_name = azurerm_resource_group.rg.name
  data_factory_name   = azurerm_data_factory.adf.name
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.adl_linked_service.name

  azure_blob_storage_path {
    folder_path = "processeddata"
    # O arquivo de saida pode ter um nome dinamico ou fixo, aqui usamos um prefixo
    file_path   = "processed_sales_data.csv"
    container_name = azurerm_storage_container.processed_data_container.name
  }

  column_delimiter  = ","
  row_delimiter     = "\n"
  first_row_as_header = true
  encoding          = "UTF-8"
}

# 7. Pipeline de Copia de Dados
resource "azurerm_data_factory_pipeline" "copy_pipeline" {
  name                = "CopySalesPipeline"
  resource_group_name = azurerm_resource_group.rg.name
  data_factory_name   = azurerm_data_factory.adf.name
  description         = "Pipeline to copy sales data from raw to processed."

  activities_json = jsonencode([
    {
      name = "CopySalesDataActivity"
      type = "Copy"
      inputs = [
        {
          referenceName = azurerm_data_factory_dataset_delimited_text.input_dataset.name
          type          = "DatasetReference"
        }
      ]
      outputs = [
        {
          referenceName = azurerm_data_factory_dataset_delimited_text.output_dataset.name
          type          = "DatasetReference"
        }
      ]
      typeProperties = {
        source = {
          type          = "DelimitedTextSource"
          storeSettings = {
            type = "AzureBlobFSReadSettings" # Para Data Lake Storage Gen2
          }
        }
        sink = {
          type          = "DelimitedTextSink"
          storeSettings = {
            type = "AzureBlobFSWriteSettings" # Para Data Lake Storage Gen2
          }
          # Exemplo de como sobrescrever (util para testes ou reprocessamento)
          # copyBehavior = "OverwriteFiles"
        }
      }
    }
  ])
}
