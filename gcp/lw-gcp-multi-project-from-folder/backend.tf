terraform {
  backend "gcs" {
    bucket = "mtothel-terraform-state"
    prefix = "folder-testing/"
  }
}
