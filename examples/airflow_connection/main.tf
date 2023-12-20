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

module "simple-composer-environment" {
  source  = "terraform-google-modules/composer/google//modules/create_environment_v1"
  version = "~> 4.0"

  project_id                       = var.project_id
  composer_env_name                = var.composer_env_name
  region                           = var.region
  composer_service_account         = var.composer_service_account
  network                          = var.network
  subnetwork                       = var.subnetwork
  use_ip_aliases                   = true
  pod_ip_allocation_range_name     = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name = var.service_ip_allocation_range_name
  node_count                       = 3
  machine_type                     = "n1-standard-1"
  image_version                    = "composer-1.20.12-airflow-1.10.15"
}

# Making the k8s master globally available is only to make the integration testing portable and should be removed
module "master-authorized-networks" {
  source  = "terraform-google-modules/composer/google//modules/master_authorized_networks"
  version = "~> 4.0"

  project_id  = var.project_id
  zone        = var.zone
  gke_cluster = module.simple-composer-environment.gke_cluster
  master_authorized_networks = [
    { cidr_block = "0.0.0.0/0", display_name = "Everybody" }
  ]
}

module "example-1" {
  source  = "terraform-google-modules/composer/google//modules/airflow_connection"
  version = "~> 4.0"

  project_id        = var.project_id
  composer_env_name = module.simple-composer-environment.composer_env_name
  region            = var.region
  id                = "example-1"
  type              = "postgres"
  host              = "host-1"
  port              = "5432"
  login             = "login1"
  password          = "p4ssw0rd"
}

module "example-2" {
  source  = "terraform-google-modules/composer/google//modules/airflow_connection"
  version = "~> 4.0"

  project_id        = var.project_id
  composer_env_name = module.simple-composer-environment.composer_env_name
  region            = var.region
  id                = "example-2"
  uri               = "gcpcloudsql://login1:p4ssw0rd@host-2:5433/db-1"
  extra = {
    database_type     = "postgres"
    project_id        = var.project_id
    location          = var.region
    instance          = "instance-1"
    use_proxy         = true
    sql_proxy_use_tcp = true
  }
}

# Connections can be defined externally if you wish
module "example-3" {
  source  = "terraform-google-modules/composer/google//modules/airflow_connection"
  version = "~> 4.0"

  project_id        = var.project_id
  composer_env_name = module.simple-composer-environment.composer_env_name
  region            = var.region
  id                = "example-3"
  uri               = "https://login1:p4ssw0rd@host-3/"
}
