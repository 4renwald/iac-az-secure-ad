data "azurerm_subscription" "sub" {}
data "azurerm_client_config" "current" {}

module "rg-github-tfstate" {
  source   = "../modules/resource-group"
  name     = var.github_tfstate_rg_name
  location = var.location
  tags     = var.tags
}

module "sa-github-tfstate" {
  source                   = "../modules/storage-account-tfstate"
  name                     = var.github_tfstate_sa_name
  resource_group_name      = module.rg-github-tfstate.name
  location                 = var.location
  tags                     = var.tags
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  container_name           = var.github_tfstate_sa_container_name
}

module "rg-github-uami" {
  source   = "../modules/resource-group"
  name     = var.github_uami_rg_name
  location = var.location
  tags     = var.tags
}

module "uami-github" {
  source   = "../modules/user-assigned-managed-identity"
  name     = "${var.github_uami_name}-${var.environment}"
  location = var.location
  rg_name  = module.rg-github-uami.name
  tags     = var.tags
}

module "tfstate_role_assignment" {
  source       = "../modules/role-assignment"
  principal_id = module.uami-github.user_assigned_identity_principal_id
  role_name    = "Storage Blob Data Contributor"
  scope_id     = module.sa-github-tfstate.id
}

module "sub_contributor_role_assignment" {
  source       = "../modules/role-assignment"
  principal_id = module.uami-github.user_assigned_identity_principal_id
  role_name    = var.contributor_role_name
  scope_id     = data.azurerm_subscription.sub.id
}

module "hcp_deployment" {
  source                 = "../modules/hcp-deployment"
  name                   = var.hcp_project_name
  app_name               = var.hcp_vault_secrets_app_name
  service_principal_name = var.hcp_project_sp_name
}

module "hcp_secrets_vault_sp_client_id" {
  source       = "../modules/hcp-vault-secrets-secret"
  app_name     =  var.hcp_vault_secrets_app_name
  project_id   =  module.hcp_deployment.hcp_project_id
  secret_name  =  "client_id"
  secret_value =  module.hcp_deployment.hcp_sp_client_id
}

module "hcp_secrets_vault_sp_client_secret" {
  source       = "../modules/hcp-vault-secrets-secret"
  app_name     =  var.hcp_vault_secrets_app_name
  project_id   =  module.hcp_deployment.hcp_project_id
  secret_name  =  "client_secret"
  secret_value =  module.hcp_deployment.hcp_sp_client_secret
}