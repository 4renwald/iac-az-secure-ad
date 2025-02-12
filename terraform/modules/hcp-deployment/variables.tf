variable "name" {
  type = string
  description = "The name of the project in HCP"
}

variable "app_name" {
  type        = string
  description = "The name of the app in HCP Vault Secrets"
}

variable "service_principal_name" {
  type        = string
  description = "The name of the Service Principal"
}