terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.20.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.0"
    }
  }
  required_version = ">= 1.5"
}
