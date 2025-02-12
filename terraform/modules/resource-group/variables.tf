variable "name" {
  type = string
  description = "The name of the azure resource group"
}

variable "location" {
  type = string
  description = "The location of the azure resource group"
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource"
}