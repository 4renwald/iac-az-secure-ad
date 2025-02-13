# shared variables across modules
variable "location" {
  type        = string
  description = "The location of the azure resource group"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "account_tier" {
  type        = string
  description = "The Tier to use for this storage account"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "The Replication Type to use for this storage account"
  default     = "LRS"
}

variable "contributor_role_name" {
  type        = string
  description = "The name of the Contributor role given to the user-assigned identity"
  default     = "Contributor"
}

# resource-group module variables
variable "github_tfstate_rg_name" {
  type        = string
  description = "The name of the azure resource group used for the github integration"
}

variable "github_uami_rg_name" {
  type        = string
  description = "The name of the azure resource group containing the user assigned managed identity"
}


# user-assigned-managed-identity module variables
variable "github_uami_name" {
  description = "The name of the user-assigned managed identity that's used for GitHub Actions"
  type        = string
}


# storage-account-tfstate module variables
variable "github_tfstate_sa_name" {
  type        = string
  description = "The name of the storage account"
}

variable "github_tfstate_sa_container_name" {
  type        = string
  description = "The name of the storage container"
  default     = "tfstate"
}


# hcp-vault-secrets module variables
variable "hcp_project_name" {
  type        = string
  description = "The name of the project in HCP"
}

variable "hcp_vault_secrets_app_name" {
  type        = string
  description = "The name of the app in HCP Vault Secrets"
}

variable "hcp_project_sp_name" {
  type        = string
  description = "The name of the HCP Service Principal linked to the project"
}

variable "github_repo_name" {
  type        = string
  description = "The name of the github repository"
}