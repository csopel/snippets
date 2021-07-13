terraform {
  backend "gcs" {
    bucket = "gcs-bucket-name"
    prefix = "multi-project-test/"
  }
}
