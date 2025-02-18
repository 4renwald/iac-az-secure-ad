resource "github_actions_environment_secret" "env_secret" {
  repository      = var.repository
  environment     = var.environment
  secret_name     = var.secret_name
  plaintext_value = var.plaintext_value
}