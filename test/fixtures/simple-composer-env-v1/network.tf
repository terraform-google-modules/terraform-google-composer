/**
 * Copyright 2020 Google LLC
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

resource "google_compute_network" "main" {
  project                 = var.project_id
  name                    = "ci-composer-test-${random_string.suffix.result}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  project                  = var.project_id
  name                     = "ci-composer-test-${random_string.suffix.result}"
  ip_cidr_range            = "10.0.0.0/17"
  region                   = var.region
  network                  = google_compute_network.main.self_link
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "ci-composer-test-pods-${random_string.suffix.result}"
    ip_cidr_range = "192.168.0.0/18"
  }

  secondary_ip_range {
    range_name    = "ci-composer-test-services-${random_string.suffix.result}"
    ip_cidr_range = "192.168.64.0/18"
  }
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}
