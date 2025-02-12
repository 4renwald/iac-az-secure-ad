variable "location" {
  type = string
  description = "The location where the user-assigned managed identity will be created"
}

variable "name" {
  type  = string
  description = "The name of the user-assigned managed identity"
}

variable "rg_name" {
  type = string
  description = "The name of the resource group in which the user-assigned managed identity will be created"
}

variable "tags" {
  type = map(string)
  description = "value of tags to assign to the user-assigned managed identity"
}