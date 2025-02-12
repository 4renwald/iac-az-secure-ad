variable "app_name" {
  type        = string
  description = "The name of the app in HCP Vault Secrets where to store the secret"
}

variable "secret_name" {
  type = string
  description = "The name of the secret"
}

variable "secret_value" {
  type = string
  description = "The value of the secret"
}

variable "project_id" {
  type        = string
  description = "The project ID"
}