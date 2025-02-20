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
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group to deploy to"
}