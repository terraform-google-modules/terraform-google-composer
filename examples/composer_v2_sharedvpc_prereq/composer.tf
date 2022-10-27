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
  source                                 = "../../modules/composer_net"
  service_project_id                     = var.service_project_id
  network_project_id                     = var.network_project_id
  region                                 = var.region
  network                                = var.network
  subnetwork                             = var.subnetwork
  composer_env_name                      = var.composer_env_name
  gke_pods_services_ip_ranges            = var.gke_pods_services_ip_ranges
  gke_subnet_ip_range                    = var.gke_subnet_ip_range
  cloud_composer_network_ipv4_cidr_block = var.cloud_composer_network_ipv4_cidr_block
  master_ipv4_cidr                       = var.master_ipv4_cidr
  cloud_sql_ipv4_cidr                    = var.cloud_sql_ipv4_cidr
  pod_ip_allocation_range_name           = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name       = var.service_ip_allocation_range_name
}
module "composer_env" {
  depends_on = [
    module.composer_net
  ]
  source = "../../modules/create_environment_v2"
  network_project_id                     = var.network_project_id
  region                                 = var.region
  network                                = var.network
  subnetwork                             = var.subnetwork
  composer_env_name                      = var.composer_env_name
  gke_pods_services_ip_ranges            = var.gke_pods_services_ip_ranges
  gke_subnet_ip_range                    = var.gke_subnet_ip_range
  cloud_composer_network_ipv4_cidr_block = var.cloud_composer_network_ipv4_cidr_block
  master_ipv4_cidr                       = var.master_ipv4_cidr
  cloud_sql_ipv4_cidr                    = var.cloud_sql_ipv4_cidr
  pod_ip_allocation_range_name           = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name       = var.service_ip_allocation_range_name
  project_id                             = "ctl-new-svc"
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
