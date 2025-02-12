output "sp_display_name" {
  value = azuread_service_principal.sp.display_name
  description = "Display name of the created Service Principal"
}

output "sp_id" {
  value = azuread_service_principal.sp.object_id
  description = "Object ID of the created Service Principal"
}