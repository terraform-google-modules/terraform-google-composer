# Cloud Composer Example within VPC SC and Shared VPC

This guide provides the infrastructure as code as a reference point for users/ customers
who want to perform all the steps documented in these links through Terraform
- Shared VPC : https://cloud.google.com/composer/docs/composer-2/configure-shared-vpc
- Firewall rules : https://cloud.google.com/composer/docs/composer-2/configure-private-ip#step_3_configure_firewall_rules
- Cloud DNS rules: https://cloud.google.com/composer/docs/composer-2/configure-vpc-sc#connectivity_to_the_restrictedgoogleapiscom_endpoint

## Compatibility

This module is meant for use with Terraform 0.13+ and tested using Terraform 1.0+.

## Usage


```hcl


module "composer_env" {
  source = "terraform-google-modules/composer/google//modules/create_environment_v2"
  project_id = var.service_project_id
  network_project_id = var.network_project_id
  composer_env_name                = var.composer_env_name
  region                           = var.region
  composer_service_account         = google_service_account.composer_sa.email
  network                          = var.network
  subnetwork                       = var.subnetwork
  pod_ip_allocation_range_name     = var.pod_ip_allocation_range_name
  service_ip_allocation_range_name = var.service_ip_allocation_range_name
  grant_sa_agent_permission        = true
  use_private_environment          = true
  enable_private_endpoint          = true
  environment_size                 = "ENVIRONMENT_SIZE_SMALL"
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
    cpu        =1
    memory_gb  = 2
    storage_gb = 1
    min_count  = 1
    max_count  = 6
  }
}

```


## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. The projects (host and service) are added within a VPC Service Control Perimeter and have the Cloud DNS/ routes configured appropriately for for Restricted VIP.
2. The Service Account you execute the module with has the right [permissions](#configure-a-service-account).
3. The Compute Engine and Kubernetes Engine APIs are [active](#enable-apis) on the project you will launch the cluster in.
4. If you are using a Shared VPC, the APIs must also be activated on the Shared VPC host project and your service account needs the proper permissions there.
5. As Composer uses GKE under the hood, certain networking configurations such as creation of network, subnets, GKE IP ranges are done before hand. This code only configures composer specific firewall rules and DNS entry.



### Configure a Service Account
In order to execute this module you must have a Service Account with the
following project roles in the Service Project:
- roles/viewer - to get the service project
- roles/composer.admin - to create the composer environment
- roles/iam.serviceAccountCreator- to create the Service account attached to the composer environment
- roles/resourcemanager.projectIamAdmin - to make iam bindings in service project for composer worker
- roles/serviceaccountuser - If you do not assign this, you get the User not authorized to act as service account 'xxxx. The user must be granted iam.serviceAccounts.actAs permission

Roles needed in the Network project (where host vpc resides)
- roles/dns.admin - Create DNS Zone that contains records to access Airflow UI
- roles/compute.securityAdmin - You can explore custom roles as well to compute.firewalls.create in network project (Compute Security Admin)
- roles/resourcemanager.projectIamAdmin - to make iam bindings in host project for Compute Network user

As the project's are within VPC SC, you may need to allow list the orchestrator service account that has these permissions
### Destroy
When destroying, destroy the composer resource first through targeted operation

terraform destroy -target=module.composer_env

Then proceed to destroying everything else
### Enable APIs
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Cloud Composer - composer.googleapis.com
- Kubernetes Engine API - container.googleapis.com
- Service Usage API - serviceusage.googleapis.com

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_sa | Service Account to be used for running Cloud Composer Environment. | `string` | n/a | yes |
| network | The name of the network being created | `string` | n/a | yes |
| project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | n/a | yes |
| region | Region where Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| service\_project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |
| service\_project\_id | The id of the project where cloud composer was created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
