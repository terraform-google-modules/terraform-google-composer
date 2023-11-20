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

module "simple-composer" {
  source = "../../../examples/simple_composer_env_v2"

  project_id                       = var.project_id
  composer_env_name                = "composer-env-${random_id.random_suffix.hex}"
  region                           = var.region
  composer_service_account         = var.composer_sa
  network                          = google_compute_network.main.name
  subnetwork                       = google_compute_subnetwork.main.name
  subnetwork_self_link             = google_compute_subnetwork.main.self_link
  pod_ip_allocation_range_name     = google_compute_subnetwork.main.secondary_ip_range[0].range_name
  service_ip_allocation_range_name = google_compute_subnetwork.main.secondary_ip_range[1].range_name
}

resource "random_id" "random_suffix" {
  byte_length = 2
}
