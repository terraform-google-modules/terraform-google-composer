# Module Cloud Composer Environment ([V2](https://cloud.google.com/composer/docs/composer-2/composer-overview))

This module is used to create a Cloud Composer V2 environment.

## Compatibility

This module is meant for use with Terraform 1.3+ and tested using Terraform 1.3+. If you find incompatibilities using Terraform >=1.3, please open an issue.

## Version

Current version is 4.0. Upgrade guides:

- [3.X -> 4.0.](/docs/upgrading_to_v4.0.md)
- [4.X -> 5.0.](/docs/upgrading_to_v5.0.md)


```hcl
module "simple-composer-environment" {
  source                               = "terraform-google-modules/composer/google//modules/create_environment_v2"
  version                              = "~> 5.0"
  project_id                           = var.project_id
  composer_env_name                    = "test-composer-env"
  region                               = "us-central1"
  composer_service_account             = var.composer_service_account
  network                              = "test-vpc"
  subnetwork                           = "test-subnet"
  pod_ip_allocation_range_name         = "test-subnet-pod-ip-name"
  service_ip_allocation_range_name     = "test-subnet-service-ip-name"
  grant_sa_agent_permission            = false
  environment_size                     = "ENVIRONMENT_SIZE_SMALL"
  enable_private_endpoint              = true
  use_private_environment              = true
  cloud_composer_connection_subnetwork = var.subnetwork_self_link
  enable_privately_used_public_ips     = var.enable_privately_used_public_ips

  scheduler = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
    count      = 2
  }

  web_server = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
  }

  worker = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
    min_count  = 2
    max_count  = 3
  }

  triggerer = {
    cpu       = 1
    memory_gb = 1
    count     = 2
  }

}

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_config\_overrides | Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example "core-dags\_are\_paused\_at\_creation". | `map(string)` | `{}` | no |
| cloud\_composer\_connection\_subnetwork | Subnetwork self-link. When specified, the environment will use Private Service Connect instead of VPC peerings to connect to CloudSQL in the Tenant Project. IP address of psc endpoint is allocated from this subnet | `string` | `null` | no |
| cloud\_composer\_network\_ipv4\_cidr\_block | The CIDR block from which IP range in tenant project will be reserved. Required if VPC peering is used to connect to CloudSql instead of PSC | `string` | `null` | no |
| cloud\_data\_lineage\_integration | Whether or not Dataplex data lineage integration is enabled. Cloud Composer environments in versions composer-2.1.2-airflow-..* and newer) | `bool` | `false` | no |
| cloud\_sql\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for Cloud SQL private service access. Required if VPC peering is used to connect to CloudSql instead of PSC | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| enable\_ip\_masq\_agent | Deploys 'ip-masq-agent' daemon set in the GKE cluster and defines nonMasqueradeCIDRs equals to pod IP range so IP masquerading is used for all destination addresses, except between pods traffic. | `bool` | `false` | no |
| enable\_private\_endpoint | Configure private access to the cluster endpoint. If true, access to the public endpoint of the GKE cluster is denied | `bool` | `false` | no |
| enable\_privately\_used\_public\_ips | When enabled, IPs from public (non-RFC1918) ranges can be used for pod\_ip\_allocation\_range\_name and service\_ip\_allocation\_range\_name. | `bool` | `false` | no |
| env\_variables | Variables of the airflow environment. | `map(string)` | `{}` | no |
| environment\_size | The environment size controls the performance parameters of the managed Cloud Composer infrastructure that includes the Airflow database. Values for environment size are: `ENVIRONMENT_SIZE_SMALL`, `ENVIRONMENT_SIZE_MEDIUM`, and `ENVIRONMENT_SIZE_LARGE`. | `string` | `"ENVIRONMENT_SIZE_MEDIUM"` | no |
| grant\_sa\_agent\_permission | Cloud Composer relies on Workload Identity as Google API authentication mechanism for Airflow. | `bool` | `true` | no |
| image\_version | The version of the aiflow running in the cloud composer environment. | `string` | `"composer-2.5.0-airflow-2.6.3"` | no |
| kms\_key\_name | Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key. | `string` | `null` | no |
| labels | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `map(string)` | `{}` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `null` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `null` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | <pre>list(object({<br>    cidr_block   = string<br>    display_name = string<br>  }))</pre> | `[]` | no |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the GKE master. Required when `use_private_environment` and `enable_private_endpoint` is `true` | `string` | `null` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| pod\_ip\_allocation\_range\_name | The name of the subnet secondary range, used to allocate IP addresses for the pods. | `string` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. "numpy"). | `map(string)` | `{}` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| resilience\_mode | Cloud Composer 2.1.15 or newer only. The resilience mode states whether high resilience is enabled for the environment or not. Values for resilience mode are `HIGH_RESILIENCE` for high resilience and `STANDARD_RESILIENCE` for standard resilience | `string` | `null` | no |
| scheduled\_snapshots\_config | The recovery configuration settings for the Cloud Composer environment | <pre>object({<br>    enabled                    = optional(bool, false)<br>    snapshot_location          = optional(string)<br>    snapshot_creation_schedule = optional(string)<br>    time_zone                  = optional(string)<br>  })</pre> | `null` | no |
| scheduler | Configuration for resources used by Airflow schedulers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    count      = number<br>  })</pre> | <pre>{<br>  "count": 2,<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| service\_ip\_allocation\_range\_name | The name of the subnet secondary range, used to allocate IP addresses for the Services. | `string` | `null` | no |
| storage\_bucket | Name of an existing Cloud Storage bucket to be used by the environment | `string` | `null` | no |
| subnetwork | The name of the subnetwork to host the composer cluster. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| tags | Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `set(string)` | `[]` | no |
| task\_logs\_retention\_storage\_mode | The mode of storage for Airflow workers task logs. Values for storage mode are CLOUD\_LOGGING\_ONLY to only store logs in cloud logging and CLOUD\_LOGGING\_AND\_CLOUD\_STORAGE to store logs in cloud logging and cloud storage. Cloud Composer 2.0.23 or newer only | `string` | `null` | no |
| triggerer | Configuration for resources used by Airflow triggerer | <pre>object({<br>    cpu       = string<br>    memory_gb = number<br>    count     = number<br>  })</pre> | `null` | no |
| use\_private\_environment | Create a private environment. | `bool` | `false` | no |
| web\_server | Configuration for resources used by Airflow web server. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| web\_server\_network\_access\_control | The network-level access control policy for the Airflow web server. If unspecified, no network-level access restrictions are applied | <pre>list(object({<br>    allowed_ip_range = string<br>    description      = string<br>  }))</pre> | `null` | no |
| worker | Configuration for resources used by Airflow workers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    min_count  = number<br>    max_count  = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "max_count": 6,<br>  "memory_gb": 7.5,<br>  "min_count": 2,<br>  "storage_gb": 5<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env | Cloud Composer Environment |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
