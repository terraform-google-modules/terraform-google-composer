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

module "composer_net" {
  source  = "terraform-google-modules/composer/google//modules/composer_net"
  version = "~> 4.0"

  service_project_id                     = var.service_project_id
  network_project_id                     = var.project_id
  composer_env_name                      = "san-composer-2"
  region                                 = "us-central1"
  network                                = var.network
  subnetwork                             = "composer-subnet"
  cloud_composer_network_ipv4_cidr_block = "192.168.192.0/24"
  master_ipv4_cidr                       = "192.168.193.0/28"
  gke_subnet_ip_range                    = ["10.100.232.0/27"]
  gke_pods_services_ip_ranges            = ["10.1.0.0/16", "10.4.0.0/16", "10.10.10.0/24", "10.10.14.0/24"]
}
module "composer_env" {
  depends_on = [
    module.composer_net
  ]
  source  = "terraform-google-modules/composer/google//modules/create_environment_v2"
  version = "~> 4.0"

  project_id                             = var.service_project_id
  network_project_id                     = var.project_id
  composer_env_name                      = "san-composer-2"
  composer_service_account               = module.composer_net.composer_sa_email
  region                                 = "us-central1"
  network                                = var.network
  subnetwork                             = "composer-subnet"
  cloud_composer_network_ipv4_cidr_block = "192.168.192.0/24"
  master_ipv4_cidr                       = "192.168.193.0/28"
  cloud_sql_ipv4_cidr                    = "192.168.0.0/17"
  pod_ip_allocation_range_name           = "composer-pods-1"
  service_ip_allocation_range_name       = "composer-services-1"
  grant_sa_agent_permission              = true
  use_private_environment                = true
  enable_private_endpoint                = true
  environment_size                       = "ENVIRONMENT_SIZE_SMALL"
  scheduler = {
    cpu        = 1
    memory_gb  = 1.875
    storage_gb = 1
    count      = 1
  }
  web_server = {
    cpu        = 1
    memory_gb  = 2
    storage_gb = 10
  }
  worker = {
    cpu        = 1
    memory_gb  = 2
    storage_gb = 1
    min_count  = 1
    max_count  = 6
  }
}
