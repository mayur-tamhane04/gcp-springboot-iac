# Project ID
variable "project_id" {
  description = "The ID of the project where resources will be created."
  type        = string
}

# Network name
variable "network_name" {
  description = "The name of the VPC network to use."
  type        = string
}
