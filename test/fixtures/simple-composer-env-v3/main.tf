/**
 * Copyright 2025 Google LLC
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
  source = "../../../examples/simple_composer_env_v3"

  project_id                = var.project_id
  composer_env_name         = "composer-env-${random_id.random_suffix.hex}"
  region                    = var.region
  composer_service_account  = var.composer_sa
  network                   = google_compute_network.main.name
  subnetwork                = google_compute_subnetwork.main.name
  create_network_attachment = true
}

resource "random_id" "random_suffix" {
  byte_length = 2
}
