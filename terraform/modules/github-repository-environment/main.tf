data "github_user" "current" {
  username = ""
}

resource "github_repository_environment" "repository_environment" {
  environment         = var.environment
  repository          = var.repository
  prevent_self_review = false
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}