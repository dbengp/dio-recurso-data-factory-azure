variable "location" {
  description = "A regiao do Azure onde os recursos serao criados."
  type        = string
  default     = "East US" # Ou "brazilsouth" ou sua regiao preferida
}

variable "resource_group_name" {
  description = "O nome do Grupo de Recursos."
  type        = string
  default     = "rg-adf-demo-iac"
}

variable "storage_account_name" {
  description = "O nome da conta de armazenamento (Data Lake Gen2). Deve ser globalmente unico."
  type        = string
  default     = "adfdemosaicdatalake" # Altere para um nome unico!
}

variable "data_factory_name" {
  description = "O nome da instancia do Azure Data Factory. Deve ser globalmente unico."
  type        = string
  default     = "adf-demo-iac-factory" # Altere para um nome unico!
}
