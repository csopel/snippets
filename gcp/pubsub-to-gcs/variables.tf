// GCP
variable "project_id" {
  description = "Project for Lacework integration resources to reside in."
  type        = string
}

variable "topic_id" {
  description = "Topic for the Pub/Sub Alert Channel.  Leave null to create one"
  type        = string
  default     = null
}

variable "bucket_name" {
  description = "Bucket name for the event logs to be written to.  Leave null to create one"
  type        = string
  default     = null
}

variable "service_account_json" {
  description = "Path to service account credential file (json format)"
  type        = string
  default     = "./creds.json"
}

variable "region" {
  description = "Region to deploy GCP assets in"
  type        = string
  default     = "us-east1"
}

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
