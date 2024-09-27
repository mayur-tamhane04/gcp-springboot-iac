variable "project_id" {
  description = "The ID of the project in which the service account will be created."
  type        = string
}

variable "account_id" {
  description = "The account ID for the service account."
  type        = string
}

variable "display_name" {
  description = "The display name of the service account."
  type        = string
}

variable "description" {
  description = "A brief description of the service account."
  type        = string
  default     = "service account"
}