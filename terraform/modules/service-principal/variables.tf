variable display_name {
  type        = string
  description = "Display name used for the azure ad application and service principal"
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource group"
}

variable owners {
  type = list(string)
  description = "List of owners for the service principal"
}