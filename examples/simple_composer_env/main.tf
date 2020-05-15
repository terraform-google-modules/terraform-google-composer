/**
 * Copyright 2019 Google LLC
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

provider "google-beta" {
  version = "~> 3.0"
}

module "simple-composer-environment" {
  source = "../../modules/create_environment"

  project_id        = var.project_id
  composer_env_name = "composer-env-${random_id.random_suffix.hex}"
  region            = "us-central1"

  node_count   = "3"
  zone         = "us-central1-f"
  machine_type = "n1-standard-8"

  network_name = google_compute_network.composer_network.id
  subnet_name  = google_compute_subnetwork.composer_subnetwork.id

  composer_service_account = var.composer_service_account
}

resource "random_id" "random_suffix" {
  byte_length = 2
}

resource "google_compute_network" "composer_network" {
  project                 = var.project_id
  name                    = "composer-network-01"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "composer_subnetwork" {
  project       = var.project_id
  name          = "composer-subnet-01"
  ip_cidr_range = "10.0.0.0/14"
  region        = "us-central1"
  network       = google_compute_network.composer_network.self_link
}
