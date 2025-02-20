module "rg-secure-ad" {
  source   = "../modules/resource-group"
  name     = "${var.rg_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}