

/******************************************
  Network Creation
 *****************************************/
module "vpc-standalone" {
  source  = "terraform-google-modules/network/google"
  version = "~> 4.1"

  project_id                             = module.host_project.project_id
  network_name                           = "composer-network"
  delete_default_internet_gateway_routes = true
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
        ip_cidr_range =  "10.1.0.0/16"
      },
      {
        range_name    = "composer-services-1"
        ip_cidr_range =  "10.4.0.0/16"
      }
    ]
  }

  routes = [
    {
      name              = "route-to-restricted-vip"
      destination_range = "199.36.153.4/30"
      next_hop_internet = "true"
    }
  ]
