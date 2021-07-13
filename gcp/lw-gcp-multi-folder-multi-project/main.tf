// Create central SA

module "gcp_service_account" {
  source     = "lacework/service-account/gcp"
  project_id = var.gcp_sa_project_id
}

// Get projects from Folder(s)
data "google_projects" "test-folder-01" {
  filter = "parent.id:556704699066"
}

data "google_projects" "test-folder-02" {
  filter = "parent.id:474403999380"
}

// Create Config Integration(s)
module "gcp_project_config_test_folder_01" {
  for_each                     = toset(data.google_projects.test-folder-01.projects[*].project_id)
  source                       = "lacework/config/gcp"
  version                      = "~> 1.0"
  project_id                   = each.key
  use_existing_service_account = true
  service_account_name         = module.gcp_service_account.name
  service_account_private_key  = module.gcp_service_account.private_key
  prefix                       = "lw-proj"
  lacework_integration_name    = each.key
  required_config_apis         = {}
}

module "gcp_project_config_test_folder_02" {
  for_each                     = toset(data.google_projects.test-folder-02.projects[*].project_id)
  source                       = "lacework/config/gcp"
  version                      = "~> 1.0"
  project_id                   = each.key
  use_existing_service_account = true
  service_account_name         = module.gcp_service_account.name
  service_account_private_key  = module.gcp_service_account.private_key
  prefix                       = "lw-proj"
  lacework_integration_name    = each.key
  required_config_apis         = {}
}
