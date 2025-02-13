variable "repository" {
    type        = string
    description = "Name of the repository"
}

variable "secret_name" {
    type        = string
    description = "Name of the secret"
}

variable "plaintext_value" {
    type = string
    description = "Encrypted value of the secret using the GitHub public key in Base64 format."
}