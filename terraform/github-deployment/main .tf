data "azurerm_subscription" "sub" {}
data "azurerm_client_config" "current" {}

module "rg-tfstate" {
  source   = "../modules/resource-group"
  name     = "${var.rg_tfstate_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

module "sa-tfstate" {
  source                   = "../modules/storage-account"
  name                     = "${var.sa_tfstate_name}${var.environment}"
  resource_group_name      = module.rg-tfstate.name
  location                 = var.location
  tags                     = var.tags
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  container_name           = var.container_tfstate_name
}

module "rg-uami" {
  source   = "../modules/resource-group"
  name     = "${var.rg_uami_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

module "uami" {
  source   = "../modules/user-assigned-managed-identity"
  name     = "${var.uami_name}-${var.environment}"
  location = var.location
  rg_name  = module.rg-uami.name
  tags     = var.tags
}

module "github_federated_credential" {
  source                             = "../modules/federated-identity-credential"
  federated_identity_credential_name = "${var.github_organization_target}-${var.github_repository}-${var.environment}"
  rg_name                            = module.rg-uami.name
  user_assigned_identity_id          = module.uami.user_assigned_identity_id
  subject                            = "repo:${var.github_organization_target}/${var.github_repository}:environment:${var.environment}"
  audience_name                      = local.default_audience_name
  issuer_url                         = local.github_issuer_url
}

module "github_federated_credential-pr" {
  source                             = "../modules/federated-identity-credential"
  federated_identity_credential_name = "${var.github_organization_target}-${var.github_repository}-pr"
  rg_name                            = module.rg-uami.name
  user_assigned_identity_id          = module.uami.user_assigned_identity_id
  subject                            = "repo:${var.github_organization_target}/${var.github_repository}:pull_request"
  audience_name                      = local.default_audience_name
  issuer_url                         = local.github_issuer_url
}

module "tfstate_role_assignment" {
  source       = "../modules/role-assignment"
  principal_id = module.uami.user_assigned_identity_principal_id
  role_name    = "Storage Blob Data Contributor"
  scope_id     = module.sa-tfstate.id
}

module "sub_contributor_role_assignment" {
  source       = "../modules/role-assignment"
  principal_id = module.uami.user_assigned_identity_principal_id
  role_name    = var.contributor_role_name
  scope_id     = data.azurerm_subscription.sub.id
}

module "hcp_deployment" {
  source                 = "../modules/hcp-deployment"
  name                   = var.hcp_project_name
  app_name               = "${var.hcp_vault_secrets_app_name}-${var.environment}"
  service_principal_name = "${var.hcp_project_sp_name}-${var.environment}"
}

module "github_actions_environment_dev" {
  source      = "../modules/github-repository-environment"
  environment = var.environment
  repository  = var.github_repository
}

module "github_actions_secret_hcp_sp_client_id" {
  source          = "../modules/github-actions-environment-secret"
  repository      = var.github_repository
  environment     = var.environment
  secret_name     = "hcp_sp_client_id"
  plaintext_value = module.hcp_deployment.hcp_sp_client_id
}

module "github_actions_secret_hcp_sp_client_secret" {
  source          = "../modules/github-actions-environment-secret"
  repository      = var.github_repository
  environment     = var.environment
  secret_name     = "hcp_sp_client_secret"
  plaintext_value = module.hcp_deployment.hcp_sp_client_secret
}

module "github_actions_secret_az_client_id" {
  source          = "../modules/github-actions-environment-secret"
  repository      = var.github_repository
  environment     = var.environment
  secret_name     = "AZURE_CLIENT_ID"
  plaintext_value = module.uami.user_assigned_identity_client_id
}

module "github_actions_secret_az_subscription_id" {
  source          = "../modules/github-actions-environment-secret"
  repository      = var.github_repository
  environment     = var.environment
  secret_name     = "AZURE_SUBSCRIPTION_ID"
  plaintext_value = data.azurerm_subscription.sub.subscription_id
}

module "github_actions_secret_az_tenant_id" {
  source          = "../modules/github-actions-environment-secret"
  repository      = var.github_repository
  environment     = var.environment
  secret_name     = "AZURE_TENANT_ID"
  plaintext_value = data.azurerm_client_config.current.tenant_id
}

module "github_actions_variable_az_rg_name" {
  source        = "../modules/github-actions-environment-variable"
  repository    = var.github_repository
  environment   = var.environment
  variable_name = "BACKEND_AZURE_RESOURCE_GROUP_NAME"
  value         = module.rg-tfstate.name
}

module "github_actions_variable_az_sa_name" {
  source        = "../modules/github-actions-environment-variable"
  repository    = var.github_repository
  environment   = var.environment
  variable_name = "BACKEND_AZURE_STORAGE_ACCOUNT_NAME"
  value         = module.sa-tfstate.sa_name
}

module "github_actions_variable_az_sa_container_name" {
  source        = "../modules/github-actions-environment-variable"
  repository    = var.github_repository
  environment   = var.environment
  variable_name = "BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME"
  value         = module.sa-tfstate.container_name
}