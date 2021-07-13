// TODO: Add logic to [create | use] a single (or existing) SA
module "gcp_service_account" {
  source     = "lacework/service-account/gcp"
  project_id = var.gcp_sa_project_id
}

data "google_projects" "folder-01" {
  filter = "parent.id:${var.gcp_folder_id}"
}

// Create Config Integration
// TODO:  Instead of using gcp_project_ids, use the google_projects data object to generate list of projects?
module "gcp_project_config" {
  for_each                     = toset(data.google_projects.folder-01.projects[*].project_id)
  source                       = "lacework/config/gcp"
  version                      = "~> 1.0"
  project_id                   = each.key
  use_existing_service_account = true
  service_account_name         = module.gcp_service_account.name
  service_account_private_key  = module.gcp_service_account.private_key
  prefix                       = "lw-proj"
  lacework_integration_name    = each.key
}
