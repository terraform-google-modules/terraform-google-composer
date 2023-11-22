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

output "composer_env_name" {
  value       = google_composer_environment.composer_env.name
  description = "Name of the Cloud Composer Environment."
}

output "composer_env_id" {
  value       = google_composer_environment.composer_env.id
  description = "ID of Cloud Composer Environment."
}

output "gke_cluster" {
  value       = google_composer_environment.composer_env.config[0].gke_cluster
  description = "Google Kubernetes Engine cluster used to run the Cloud Composer Environment."
}

output "gcs_bucket" {
  value       = google_composer_environment.composer_env.config[0].dag_gcs_prefix
  description = "Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment."
}

output "airflow_uri" {
  value       = google_composer_environment.composer_env.config[0].airflow_uri
  description = "URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment."
}

output "composer_env" {
  value       = google_composer_environment.composer_env
  description = "Cloud Composer Environment"
}
