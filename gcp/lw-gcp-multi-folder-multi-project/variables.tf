// Lacework
variable "lacework_account" {
  description = "Lacework Account to integrate with"
  type        = string
}
variable "lacework_api_key" {
  description = "API Key to use for Lacework integrations"
  type        = string
  sensitive   = true
}
variable "lacework_api_secret" {
  description = "API Secret for lacework_api_key"
  type        = string
  sensitive   = true
}

// Google Cloud
variable "gcp_sa_project_id" {
  description = "Project for Lacework integration Service Account to reside in"
  type        = string
}
