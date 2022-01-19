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

output "project_id" {
  description = "Project ID where Cloud Composer Environment is created."
  value       = var.project_id
}

output "composer_env_name" {
  description = "Name of the Cloud Composer Environment."
  value       = module.simple-composer.composer_env_name
}

output "network" {
  description = "The Cloud Composer Network."
  value       = google_compute_network.main.name
}

output "subnetwork" {
  description = "The Cloud Composer Subnetwork."
  value       = google_compute_subnetwork.main.name
}

output "pod_ip_allocation_range_name" {
  description = "The secondary IP range used for pods"
  value       = google_compute_subnetwork.main.secondary_ip_range[0].range_name
}

output "service_ip_allocation_range_name" {
  description = "The secondary IP range used for services"
  value       = google_compute_subnetwork.main.secondary_ip_range[1].range_name
}

output "composer_env_id" {
  description = "ID of Cloud Composer Environment."
  value       = module.simple-composer.composer_env_id
}

output "gke_cluster" {
  description = "Google Kubernetes Engine cluster used to run the Cloud Composer Environment."
  value       = module.simple-composer.gke_cluster
}

output "gcs_bucket" {
  description = "Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment."
  value       = module.simple-composer.gcs_bucket
}

output "airflow_uri" {
  description = "URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment."
  value       = module.simple-composer.airflow_uri
}
