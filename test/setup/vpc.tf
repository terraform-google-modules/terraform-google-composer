

/******************************************
  Network Creation
 *****************************************/
module "shared-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.0"

  project_id                             = module.project.project_id
  network_name                           = "composer-network"
  delete_default_internet_gateway_routes = false
  subnets = [
    {
      subnet_name           = "composer-subnet"
      subnet_ip             = "10.100.232.0/27"
      subnet_region         = "us-central1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    "composer-subnet" = [
      {
        range_name    = "composer-pods-1"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "composer-services-1"
        ip_cidr_range = "10.4.0.0/16"
      }
    ]
  }

  routes = [
    {
      name              = "route-to-restricted-vip"
      destination_range = "199.36.153.4/30"
      next_hop_internet = "true"
    },
    {
      name              = "internet-for-bastion-1"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
      priority          = 1000
    }
  ]
}
/*
resource "google_compute_shared_vpc_host_project" "host" {
  project = module.project.project_id
}
*/
resource "google_compute_router" "router" {
  project = module.project.project_id
  name    = "nat-router"
  network = module.shared-vpc.network_self_link
  region  = "us-central1"
}

module "cloud-nat-shared-vpc" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 2.2.1"
  project_id                         = module.project.project_id
  region                             = "us-central1"
  router                             = google_compute_router.router.name
  name                               = "nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
/*
resource "google_compute_shared_vpc_service_project" "service-project" {
 # depends_on = [google_folder_iam_binding.shared-vpc-iam, google_organization_iam_binding.shared-vpc-org-iam,google_compute_shared_vpc_host_project.host ]
  depends_on = [google_folder_iam_binding.shared-vpc-iam,google_compute_shared_vpc_host_project.host ]
  host_project    = module.project.project_id
  service_project = module.service_project.project_id
}
*/
