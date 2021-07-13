# Configure GCP credentials
locals {
  gcp_credentials = jsondecode(file(var.service_account_json))
}

// Create Pub/Sub Topic
resource "google_pubsub_topic" "lw-alerts" {
  count   = var.topic_id != null ? 0 : 1
  project = var.project_id
  name    = "lw-alerts"
}

resource "google_pubsub_topic_iam_member" "publisher" {
  project = var.project_id
  topic   = var.topic_id != null ? var.topic_id : google_pubsub_topic.lw-alerts[0].name
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${local.gcp_credentials["client_email"]}"
}

resource "google_pubsub_topic_iam_member" "subscriber" {
  project = var.project_id
  topic   = var.topic_id != null ? var.topic_id : google_pubsub_topic.lw-alerts[0].name
  role    = "roles/pubsub.subscriber"
  member  = "serviceAccount:${local.gcp_credentials["client_email"]}"
}

// Create Pub/Sub Alert Channel
resource "lacework_alert_channel_gcp_pub_sub" "lw-alerts" {
  name       = "gcp-pub-sub-event-export"
  project_id = var.project_id
  topic_id   = var.topic_id != null ? var.topic_id : google_pubsub_topic.lw-alerts[0].name
  credentials {
    client_id      = local.gcp_credentials["client_id"]
    client_email   = local.gcp_credentials["client_email"]
    private_key_id = local.gcp_credentials["private_key_id"]
    private_key    = local.gcp_credentials["private_key"]
  }
}
// Create GCS Bucket
resource "google_storage_bucket" "events" {
  count                       = var.bucket_name != null ? 0 : 1
  project                     = var.project_id
  name                        = "${var.lacework_account}-${var.topic_id != null ? var.topic_id : google_pubsub_topic.lw-alerts[0].name}"
  storage_class               = "REGIONAL"
  location                    = var.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = var.bucket_name != null ? var.bucket_name : google_storage_bucket.events[0].name
  role   = "roles/storage.objectCreator"
  members = [
    "serviceAccount:${local.gcp_credentials["client_email"]}",
  ]
}

resource "google_storage_bucket_object" "gcf_code" {
  name   = "code.zip"
  bucket = var.bucket_name != null ? var.bucket_name : google_storage_bucket.events[0].name
  source = "./files/code.zip"
}

// Create Cloud Function
resource "google_cloudfunctions_function" "lw-events" {
  project     = var.project_id
  name        = "lw-event-export"
  description = "GCF to take Lacework Events and write them to GCS"
  runtime     = "python39"
  region      = var.region

  available_memory_mb   = 128
  source_archive_bucket = var.bucket_name != null ? var.bucket_name : google_storage_bucket.events[0].name
  source_archive_object = google_storage_bucket_object.gcf_code.name
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = var.topic_id != null ? var.topic_id : google_pubsub_topic.lw-alerts[0].name
  }
  service_account_email = local.gcp_credentials["client_email"]
  timeout               = 60
  entry_point           = "main"

  environment_variables = {
    lw_instance = var.lacework_account
    bucket_name = var.bucket_name != null ? var.bucket_name : google_storage_bucket.events[0].name
  }
}
