output "hcp_sp_client_id" {
    value = hcp_service_principal_key.hcp_sp_key.client_id
}

output "hcp_sp_client_secret" {
    value     = hcp_service_principal_key.hcp_sp_key.client_secret
    sensitive = true
}

output "hcp_project_id" {
    value = hcp_project.project.resource_id
}