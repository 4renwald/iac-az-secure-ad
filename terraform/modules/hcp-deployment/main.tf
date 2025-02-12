resource "hcp_project" "project" {
  name  = var.name
}

resource "hcp_vault_secrets_app" "vault_app" {
  app_name   = var.app_name
  project_id = hcp_project.project.resource_id
}

resource "hcp_service_principal" "hcp_sp" {
  name   = var.service_principal_name
  parent = hcp_project.project.resource_name
}

resource "hcp_service_principal_key" "hcp_sp_key" {
  service_principal = hcp_service_principal.hcp_sp.resource_name
}