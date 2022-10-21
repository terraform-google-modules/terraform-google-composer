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


locals {
  cloud_composer_service_account     = format("serviceAccount:service-%s@cloudcomposer-accounts.iam.gserviceaccount.com", data.google_project.service_project.number)
  cloud_services_service_account     = format("serviceAccount:%s@cloudservices.gserviceaccount.com", data.google_project.service_project.number)
  services_container_service_account = format("serviceAccount:service-%s@container-engine-robot.iam.gserviceaccount.com", data.google_project.service_project.number)
  host_container_service_account     = format("serviceAccount:service-%s@container-engine-robot.iam.gserviceaccount.com", data.google_project.host_project.number)
  all_sa_list                        = split(",","${local.cloud_composer_service_account},${local.cloud_services_service_account},${local.services_container_service_account},${local.host_container_service_account}")
}


data "google_project" "service_project" {
  project_id = var.service_project_id
}

data "google_project" "host_project" {
  project_id = var.network_project_id
}

/***
For a user-managed service account that runs Cloud Composer environments:
For a public IP configuration, assign the Composer Worker (composer.worker) role.
For a private IP configuration:
Assign the Composer Worker (composer.worker) role.
Assign the Service Account User (iam.serviceAccountUser) role
***/
resource "google_service_account" "composer_sa" {
  account_id   = "composer-sa"
  display_name = "composer-sa"
  project      = var.service_project_id
}

resource "google_project_iam_member" "composer_worker" {
  project = var.service_project_id
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}

resource "google_project_iam_member" "service_account_user" {
  project = var.service_project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.composer_sa.email}"
}
/***

3. Grant compute.networkUser to the service project's Google APIs service account at the host project level. 
This is a requirement for managed instance groups used with Shared VPC because this
type of service account performs tasks such as instance creation.

**/
resource "google_project_iam_member" "composer_network_user_binding_service_project_cloud_services" {
  project = var.network_project_id
  role    = "roles/compute.networkUser"
  member  = local.cloud_services_service_account
}
/***
4. Grant compute.networkUser at the subnet level to the following: 
a. service project's GKE service accounts 
b. Cloud Composer google managed service account from service project
c. GKE google managed service account from service project
d. GKE google managed service account from host project
For each service account, add another role, add compute.networkUser. This permission must be granted at 
the network level to allow a service account to set up the VPC peering architecture required by Cloud Composer.
***/

resource "google_compute_subnetwork_iam_member" "composer_managed_sa_iam_bindings_for_each" {
  for_each   = toset(local.all_sa_list)
  project    = var.network_project_id
  region     = var.region
  subnetwork = var.subnetwork
  role       = "roles/compute.networkUser"
  member     = each.value
}

/***
5. In the host project, grant the Host Service Agent User of GKE Service Account of the service project 
at project level to use the GKE Service Account of the host project to configure shared network resources. 
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc#kubernetes_engine_access

This binding allows the service project's GKE service account to perform network management operations 
in the host project, as if it were the host project's GKE service account. 
This role can only be granted to a service project's GKE service account.
***/

resource "google_project_iam_member" "service_project_gke_host_agent" {
  project = var.network_project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = local.services_container_service_account
}
/***
7. In the service project, if this is the first Cloud Composer environment, then provision the Composer Agent Service Account:
***/
resource "google_project_service_identity" "composer_sa" {
  provider = google-beta

  project = data.google_project.service_project.project_id
  service = "composer.googleapis.com"
}


/***
8. In the host project,Edit permissions for the Composer Agent Service Account, 
service-SERVICE_PROJECT_NUMBER@cloudcomposer-accounts.iam.gserviceaccount.com)
For this account, add another role:
For Private IP environments, add the Composer Shared VPC Agent role.
***/
resource "google_project_iam_member" "composer_shared_vpc_agent_composer_sa" {
  project = var.network_project_id
  role    = "roles/composer.sharedVpcAgent"
  member  = "serviceAccount:${google_project_service_identity.composer_sa.email}"
}

