resource "github_actions_secret" "example_secret" {
  repository       = var.repository
  secret_name      = var.secret_name
  plaintext_value = var.plaintext_value
}