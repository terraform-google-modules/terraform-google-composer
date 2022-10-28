# Composer Network Module Example

This example illustrates how to use the `composer-net` module. Please see examples directory (Composer_v2_shared_vpc_prereq) on how this can be used.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_composer\_network\_ipv4\_cidr\_block | The CIDR block from which IP range in tenant project will be reserved. | `string` | `null` | no |
| cloud\_sql\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for Cloud SQL. | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| enable\_private\_endpoint | Configure public access to the cluster endpoint. | `bool` | `false` | no |
| gke\_pods\_services\_ip\_ranges | The secondary IP ranges for the GKE Pods and Services IP ranges | `list(string)` | n/a | yes |
| gke\_subnet\_ip\_range | The GKE subnet IP range | `list(string)` | n/a | yes |
| grant\_sa\_agent\_permission | Cloud Composer relies on Workload Identity as Google API authentication mechanism for Airflow. | `bool` | `true` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | <pre>list(object({<br>    cidr_block   = string<br>    display_name = string<br>  }))</pre> | `[]` | no |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the master. | `string` | `null` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | n/a | yes |
| pod\_ip\_allocation\_range\_name | The name of the cluster's secondary range used to allocate IP addresses to pods. | `string` | `null` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| service\_ip\_allocation\_range\_name | The name of the services' secondary range used to allocate IP addresses to the cluster. | `string` | `null` | no |
| service\_project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| subnetwork | The subnetwork to host the composer cluster. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| composer\_sa\_email | n/a |
| service\_project\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
