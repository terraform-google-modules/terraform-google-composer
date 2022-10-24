// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "simple-shared-vpc-composer" {
  source = "../../../examples/composer_v2_sharedvpc_prereq"

  service_project_id                     = "ctl-new-svc"
  network_project_id                     = "ctl-new-hvpc"
  composer_env_name                      = "san-composer-2"
  region                                 = "us-central1"
  network                                = "composer-network"
  subnetwork                             = "composer-subnetwork"
  cloud_composer_network_ipv4_cidr_block = "192.168.192.0/24"
  master_ipv4_cidr                       = "192.168.193.0/28"
  cloud_sql_ipv4_cidr                    = "192.168.0.0/17"
  pod_ip_allocation_range_name           = "composer-pods-1"
  service_ip_allocation_range_name       = "composer-services-1"
  gke_subnet_ip_range                    = ["10.100.232.0/27"]
  gke_pods_services_ip_ranges            = ["10.1.0.0/16", "10.4.0.0/16", "10.10.10.0/24", "10.10.14.0/24"]
}