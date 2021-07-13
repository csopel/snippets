terraform {
  backend "gcs" {
    bucket = "mtothel-terraform-state"
    prefix = "multi-folder-testing/"
  }
}
