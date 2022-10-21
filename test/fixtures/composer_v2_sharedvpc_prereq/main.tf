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