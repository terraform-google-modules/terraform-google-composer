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

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  version = "~> 3.3"
}

provider "google-beta" {
  version = "~> 3.3"
}

provider "external" {
  version = "2.1.0"
}

module "simple-composer-environment" {
  source                           = "../../modules/create_environment_v1"
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
}

# Making the k8s master globally available is only to make the integration testing portable and should be removed
module "master-authorized-networks" {
  source      = "../../modules/master_authorized_networks"
  project_id  = var.project_id
  zone        = var.zone
  gke_cluster = module.simple-composer-environment.gke_cluster
  master_authorized_networks = [
    { cidr_block = "0.0.0.0/0", display_name = "Everybody" }
  ]
}

# Pools can be defined externally if you wish
module "pool-1" {
  source            = "../../modules/airflow_pool"
  project_id        = var.project_id
  composer_env_name = module.simple-composer-environment.composer_env_name
  region            = var.region
  pool_name         = "pool-1"
  slot_count        = 2222
  description       = "Pool 1"
}

