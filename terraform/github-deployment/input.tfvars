github_repository           = "iac-az-secure-ad"
environment                 = "dev"
github_organization_target  = "4renwald"

# Inputs for the github tfstate backend configuration
rg_tfstate_name        = "rg-secure-ad-tfstate"
sa_tfstate_name        = "sasecureadtfstate"
container_tfstate_name = "tfstate"

# Inputs for the github user assigned managed identity resource group
rg_uami_name = "rg-secure-ad-uami"
uami_name    = "uami-secure-ad"

# Inputs for the hcp vault secrets app
hcp_project_name            = "iac-az-secure-ad"
hcp_vault_secrets_app_name  = "hcp-app-secure-ad"
hcp_project_sp_name         = "hcp-sp-secure-ad"

# Shared inputs for azure
location = "canadacentral"
tags = {
  environment = "dev"
  owner       = "arenwald"
}