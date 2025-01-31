# Module Cloud Composer Environment ([v3](https://cloud.google.com/composer/docs/composer-3/composer-overview))

This module is used to create a Cloud Composer v3 environment.

## Compatibility

This module is meant for use with Terraform 1.3+ and tested using Terraform 1.3+. If you find incompatibilities using Terraform >=1.3, please open an issue.


```hcl
module "simple-composer-environment" {
  source                               = "terraform-google-modules/composer/google//modules/create_environment_v3"
  version                              = "~> 7.0"
  project_id                           = var.project_id
  composer_env_name                    = "test-composer-env"
  region                               = "us-central1"
  composer_service_account             = var.composer_service_account
  network                              = "test-vpc"
  subnetwork                           = "test-subnet"
  grant_sa_agent_permission            = false
  environment_size                     = "ENVIRONMENT_SIZE_SMALL"
  use_private_environment              = true
  composer_network_attachment_name     = "composer-na"

  scheduler = {
    cpu        = 0.5
    memory_gb  = 1.875
    storage_gb = 1
    count      = 2
  }

  dag_processor = {
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
| cloud\_data\_lineage\_integration | Whether or not Dataplex data lineage integration is enabled. Cloud Composer environments in versions composer-2.1.2-airflow-..* and newer) | `bool` | `false` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_network\_attachment\_name | Name for PSC (Private Service Connect) Network entry point. | `string` | `null` | no |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| create\_network\_attachment | Either create a new network attachment or use existing one. If true, provide the subnet details. | `bool` | `true` | no |
| dag\_processor | Configuration for resources used by Airflow workers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    count      = number<br>  })</pre> | <pre>{<br>  "count": 2,<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| env\_variables | Variables of the airflow environment. | `map(string)` | `{}` | no |
| environment\_size | The environment size controls the performance parameters of the managed Cloud Composer infrastructure that includes the Airflow database. Values for environment size are: `ENVIRONMENT_SIZE_SMALL`, `ENVIRONMENT_SIZE_MEDIUM`, and `ENVIRONMENT_SIZE_LARGE`. | `string` | `"ENVIRONMENT_SIZE_MEDIUM"` | no |
| grant\_sa\_agent\_permission | Cloud Composer relies on Workload Identity as Google API authentication mechanism for Airflow. | `bool` | `true` | no |
| image\_version | The version of the aiflow running in the cloud composer environment. | `string` | `"composer-3-airflow-2.10.2-build.5"` | no |
| kms\_key\_name | Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key. | `string` | `null` | no |
| labels | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `map(string)` | `{}` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `null` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `null` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. "numpy"). | `map(string)` | `{}` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| resilience\_mode | Cloud Composer 2.1.15 or newer only. The resilience mode states whether high resilience is enabled for the environment or not. Values for resilience mode are `HIGH_RESILIENCE` for high resilience and `STANDARD_RESILIENCE` for standard resilience | `string` | `null` | no |
| scheduled\_snapshots\_config | The recovery configuration settings for the Cloud Composer environment | <pre>object({<br>    enabled                    = optional(bool, false)<br>    snapshot_location          = optional(string)<br>    snapshot_creation_schedule = optional(string)<br>    time_zone                  = optional(string)<br>  })</pre> | `null` | no |
| scheduler | Configuration for resources used by Airflow schedulers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    count      = number<br>  })</pre> | <pre>{<br>  "count": 2,<br>  "cpu": 1,<br>  "memory_gb": 4,<br>  "storage_gb": 5<br>}</pre> | no |
| storage\_bucket | Name of an existing Cloud Storage bucket to be used by the environment | `string` | `null` | no |
| subnetwork | The name of the subnetwork to host the composer cluster. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| tags | Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `set(string)` | `[]` | no |
| task\_logs\_retention\_storage\_mode | The mode of storage for Airflow workers task logs. Values for storage mode are CLOUD\_LOGGING\_ONLY to only store logs in cloud logging and CLOUD\_LOGGING\_AND\_CLOUD\_STORAGE to store logs in cloud logging and cloud storage. Cloud Composer 2.0.23 or newer only | `string` | `null` | no |
| triggerer | Configuration for resources used by Airflow triggerer | <pre>object({<br>    cpu       = string<br>    memory_gb = number<br>    count     = number<br>  })</pre> | `null` | no |
| use\_private\_environment | Create a private environment. If true, a private Composer environment will be created. | `bool` | `false` | no |
| web\_server | Configuration for resources used by Airflow web server. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| web\_server\_network\_access\_control | The network-level access control policy for the Airflow web server. If unspecified, no network-level access restrictions are applied | <pre>list(object({<br>    allowed_ip_range = string<br>    description      = string<br>  }))</pre> | `null` | no |
| web\_server\_plugins\_mode | Web server plugins configuration. Can be either 'ENABLED' or 'DISABLED'. Defaults to 'ENABLED'. | `string` | `"ENABLED"` | no |
| worker | Configuration for resources used by Airflow workers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    min_count  = number<br>    max_count  = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "max_count": 6,<br>  "memory_gb": 7.5,<br>  "min_count": 2,<br>  "storage_gb": 5<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env | Cloud Composer Environment |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
