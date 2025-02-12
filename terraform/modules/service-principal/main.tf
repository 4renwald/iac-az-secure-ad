resource "azuread_application" "app" {
  display_name     = var.display_name
  sign_in_audience = "AzureADMyOrg"
}

resource "azuread_service_principal" "sp" {
  client_id                    = azuread_application.app.client_id
  app_role_assignment_required = false
  owners                       = var.owners
}