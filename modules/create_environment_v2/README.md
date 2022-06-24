# Module Cloud Composer Environment ([V2](https://cloud.google.com/composer/docs/composer-2/composer-overview))

This optional module is used to create a Cloud Composer environment.

```hcl
module "composer" {
  source = "terraform-google-modules/composer/google//modules/create_environment_v2"

  project = "project-123"
  name    = "Composer-Prod-Env"
  region  = "us-central1"
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_config\_overrides | Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example "core-dags\_are\_paused\_at\_creation". | `map(string)` | `{}` | no |
| cloud\_composer\_connection\_subnetwork | When specified, the environment will use Private Service Connect instead of VPC peerings to connect to Cloud SQL in the Tenant Project | `string` | `null` | no |
| cloud\_composer\_network\_ipv4\_cidr\_block | The CIDR block from which IP range in tenant project will be reserved. | `string` | `null` | no |
| cloud\_sql\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for Cloud SQL. | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| enable\_private\_endpoint | Configure public access to the cluster endpoint. | `bool` | `false` | no |
| env\_variables | Variables of the airflow environment. | `map(string)` | `{}` | no |
| environment\_size | The environment size controls the performance parameters of the managed Cloud Composer infrastructure that includes the Airflow database. Values for environment size are: ENVIRONMENT\_SIZE\_SMALL, ENVIRONMENT\_SIZE\_MEDIUM, and ENVIRONMENT\_SIZE\_LARGE. | `string` | `"ENVIRONMENT_SIZE_MEDIUM"` | no |
| grant\_sa\_agent\_permission | Cloud Composer relies on Workload Identity as Google API authentication mechanism for Airflow. | `bool` | `true` | no |
| image\_version | The version of the aiflow running in the cloud composer environment. | `string` | `"composer-2.0.2-airflow-2.1.4"` | no |
| labels | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `map(string)` | `{}` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `null` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `null` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | <pre>list(object({<br>    cidr_block   = string<br>    display_name = string<br>  }))</pre> | `[]` | no |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the master. | `string` | `null` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| pod\_ip\_allocation\_range\_name | The name of the cluster's secondary range used to allocate IP addresses to pods. | `string` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. "numpy"). | `map(string)` | `{}` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| scheduler | Configuration for resources used by Airflow schedulers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    count      = number<br>  })</pre> | <pre>{<br>  "count": 2,<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| service\_ip\_allocation\_range\_name | The name of the services' secondary range used to allocate IP addresses to the cluster. | `string` | `null` | no |
| subnetwork | The subnetwork to host the composer cluster. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| tags | Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `set(string)` | `[]` | no |
| use\_private\_environment | Enable private environment. | `bool` | `false` | no |
| web\_server | Configuration for resources used by Airflow web server. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "memory_gb": 7.5,<br>  "storage_gb": 5<br>}</pre> | no |
| web\_server\_allowed\_ip\_ranges | The network-level access control policy for the Airflow web server. If unspecified, no network-level access restrictions will be applied. | <pre>list(object({<br>    value       = string,<br>    description = string<br>  }))</pre> | `null` | no |
| worker | Configuration for resources used by Airflow workers. | <pre>object({<br>    cpu        = string<br>    memory_gb  = number<br>    storage_gb = number<br>    min_count  = number<br>    max_count  = number<br>  })</pre> | <pre>{<br>  "cpu": 2,<br>  "max_count": 6,<br>  "memory_gb": 7.5,<br>  "min_count": 2,<br>  "storage_gb": 5<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
