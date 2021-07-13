terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "~> 0.5"
    }
  }
}

provider "google" {}

provider "lacework" {
  account    = var.lacework_account
  api_key    = var.lacework_api_key
  api_secret = var.lacework_api_secret
}
