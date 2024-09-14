terraform {
  #   backend "gcs" {
  #     bucket = "eisa-tfstate"
  #     prefix = "terraform/state"
  #   }

  required_version = "~> 1.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.3"
    }
  }
}

provider "google" {
  project = var.common.project
  region  = var.common.region
  zone    = var.common.zone
}
