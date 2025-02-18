resource "github_actions_environment_variable" "gh_actions_env_variable" {
  environment   = var.environment
  repository    = var.repository
  variable_name = var.variable_name
  value         = var.value
}