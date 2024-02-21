/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_string" "key_suffix" {
  length  = 5
  special = false
  upper   = false
}

# Create a bucket to store the snapshots
resource "google_storage_bucket" "my_bucket" {
  project                     = var.project_id
  name                        = "snapshot-bucket-${random_string.key_suffix.result}"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "object_admin" {
  bucket = google_storage_bucket.my_bucket.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.composer_service_account}"
}

module "simple-composer-environment" {
  source  = "terraform-google-modules/composer/google//modules/create_environment_v2"
  version = "~> 4.0"

  project_id                           = var.project_id
  composer_env_name                    = var.composer_env_name
  region                               = var.region
  composer_service_account             = var.composer_service_account
  network                              = var.network
  subnetwork                           = var.subnetwork
  pod_ip_allocation_range_name         = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name     = var.service_ip_allocation_range_name
  grant_sa_agent_permission            = false
  environment_size                     = "ENVIRONMENT_SIZE_SMALL"
  enable_private_endpoint              = true
  use_private_environment              = true
  cloud_composer_connection_subnetwork = var.subnetwork_self_link
  cloud_data_lineage_integration       = true
  resilience_mode                      = "STANDARD_RESILIENCE"

  scheduler = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
    count      = 2

  }
  web_server = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
  }

  worker = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
    min_count  = 2
    max_count  = 3
  }

  triggerer = {
    cpu       = 1
    memory_gb = 1
    count     = 2
  }

  scheduled_snapshots_config = {
    enabled                    = true
    snapshot_location          = google_storage_bucket.my_bucket.url
    snapshot_creation_schedule = "0 4 * * *"
    time_zone                  = "UTC+01"
  }

  maintenance_start_time = "2023-01-01T00:00:00Z"
  maintenance_end_time   = "2023-01-01T12:00:00Z"
  maintenance_recurrence = "FREQ=WEEKLY;BYDAY=SU,SA"

  depends_on = [
    google_storage_bucket_iam_member.object_admin,
  ]
  web_server_network_access_control = [
    {
      allowed_ip_range = "192.0.2.0/24"
      description      = "office net 1"
    },
    {
      allowed_ip_range = "192.0.4.0/24"
      description      = "office net 2"
    },
  ]
}
