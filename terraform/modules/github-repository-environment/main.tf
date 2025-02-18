data "github_user" "current" {
  username = ""
}

resource "github_repository_environment" "repository_environment" {
  environment         = var.environment
  repository          = var.repository
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}