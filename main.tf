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

module "composer-environment" {
  source = "./modules/create_environment"

  project_id                       = var.project_id
  composer_env_name                = var.composer_env_name
  region                           = var.region
  labels                           = var.labels
  network                          = var.network
  subnetwork                       = var.subnetwork
  network_project_id               = var.network_project_id
  subnetwork_region                = var.subnetwork_region
  zone                             = var.zone
  node_count                       = var.node_count
  machine_type                     = var.machine_type
  composer_service_account         = var.composer_service_account
  disk_size                        = var.disk_size
  oauth_scopes                     = var.oauth_scopes
  tags                             = var.tags
  use_ip_aliases                   = var.use_ip_aliases
  pod_ip_allocation_range_name     = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name = var.service_ip_allocation_range_name
  airflow_config_overrides         = var.airflow_config_overrides
  env_variables                    = var.env_variables
  image_version                    = var.image_version
  pypi_packages                    = var.pypi_packages
  python_version                   = var.python_version
  cloud_sql_ipv4_cidr              = var.cloud_sql_ipv4_cidr
  web_server_ipv4_cidr             = var.web_server_ipv4_cidr
  master_ipv4_cidr                 = var.master_ipv4_cidr
  enable_private_endpoint          = var.enable_private_endpoint
  kms_key_name                     = var.kms_key_name
  web_server_allowed_ip_ranges     = var.web_server_allowed_ip_ranges
}
