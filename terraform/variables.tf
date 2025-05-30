variable "location" {
  description = "A região do Azure onde os recursos serão criados."
  type        = string
  default     = "East US" # Ou "brazilsouth" ou sua região preferida
}

variable "resource_group_name" {
  description = "O nome do Grupo de Recursos."
  type        = string
  default     = "rg-adf-demo-iac"
}

variable "storage_account_name" {
  description = "O nome da conta de armazenamento (Data Lake Gen2). Deve ser globalmente único."
  type        = string
  default     = "adfdemosaicdatalake" # Altere para um nome único!
}

variable "data_factory_name" {
  description = "O nome da instância do Azure Data Factory. Deve ser globalmente único."
  type        = string
  default     = "adf-demo-iac-factory" # Altere para um nome único!
}
