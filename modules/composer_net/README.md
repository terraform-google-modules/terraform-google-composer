# Composer Network Module Example

This example illustrates how to use the `composer-net` module. Please see examples directory (Composer_v2_shared_vpc_prereq) on how this can be used.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloud\_composer\_network\_ipv4\_cidr\_block | The CIDR block from which IP range in tenant project will be reserved. | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_sa\_name | Service Account name to be used for running Cloud Composer Environment. | `string` | `"composer-sa"` | no |
| dns\_name | The DNS name of the managed zone | `string` | `"composer.cloud.google.com."` | no |
| dns\_zone\_name | Composer DNS private zone name | `string` | `"composer-google-cloud-dns"` | no |
| enable\_firewall\_logging | Enable logging for firewall rules | `bool` | `true` | no |
| firewall\_logging\_metadata | The logging metadata to include in firewall logs. Options: INCLUDE\_ALL\_METADATA or EXCLUDE\_ALL\_METADATA | `string` | `"INCLUDE_ALL_METADATA"` | no |
| gke\_pods\_services\_ip\_ranges | The secondary IP ranges for the GKE Pods and Services IP ranges | `list(string)` | n/a | yes |
| gke\_subnet\_ip\_range | The GKE subnet IP range | `list(string)` | n/a | yes |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the master. | `string` | `null` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| service\_project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| subnetwork | The subnetwork to host the composer cluster. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| composer\_sa\_email | composer service account email |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
