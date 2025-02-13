terraform {
  required_version = ">=1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.102.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }
  }
}

provider "github" {}

provider "hcp" {}

provider "azuread" {}

provider "azurerm" {
  features {}
}