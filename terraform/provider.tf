terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
  }
  backend "gcs" {
    bucket = "springboot-app-tf-state"
    prefix = "terraform/state"
  }
}
