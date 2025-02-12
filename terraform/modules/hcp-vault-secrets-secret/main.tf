resource "hcp_vault_secrets_secret" "secret" {
  app_name     = var.app_name
  secret_name  = var.secret_name
  secret_value = var.secret_value
  project_id   = var.project_id
}