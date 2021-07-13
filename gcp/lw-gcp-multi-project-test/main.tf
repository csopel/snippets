// TODO: Add logic to [create | use] a single existing SA

// Create Config Integration
module "gcp_project_config" {
  for_each   = toset(var.gcp_project_ids)
  source     = "lacework/config/gcp"
  version    = "~> 1.0"
  project_id = each.key
}
// Create Audit Log Integration
module "gcp_project_audit_log" {
  for_each = toset(var.gcp_project_ids)
  source   = "lacework/audit-log/gcp"
  version  = "~> 2.0"

  bucket_force_destroy         = true
  use_existing_service_account = true
  service_account_name         = module.gcp_project_config[each.key].service_account_name
  service_account_private_key  = module.gcp_project_config[each.key].service_account_private_key
  project_id                   = each.key
}
