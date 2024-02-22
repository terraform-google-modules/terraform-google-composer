# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

/***************************************
composer.cloud.google.com
***************************************/

resource "random_string" "composer_cloud_zone" {
  length           = 4
  special          = false
}

resource "google_dns_managed_zone" "composer_cloud_zone" {
  name        = "composer-google-cloud-dns-${random_string.composer_cloud_zone.id}"
  project     = var.network_project_id
  dns_name    = "composer.cloud.google.com."
  description = "composer.cloud.google.com zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "https://www.googleapis.com/compute/v1/projects/${var.network_project_id}/global/networks/${var.network}"
    }
  }
}

resource "google_dns_record_set" "composer_cloud_zone-dev-A-record" {
  name    = "composer.cloud.google.com."
  project = var.network_project_id
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.composer_cloud_zone.name

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "composer_cloud_zone-CNAME" {
  name    = "*.composer.cloud.google.com."
  project = var.network_project_id
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.composer_cloud_zone.name

  rrdatas = ["composer.cloud.google.com."]
}
