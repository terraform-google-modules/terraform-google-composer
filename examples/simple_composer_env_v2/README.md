# Simple Cloud Composer Environment (V2) Example

This example illustrates how to use the `composer` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of Cloud Composer Environment. | `string` | `"ci-composer"` | no |
| composer\_service\_account | Service Account to be used for running Cloud Composer Environment. | `string` | n/a | yes |
| network | Network where Cloud Composer is created. | `string` | n/a | yes |
| pod\_ip\_allocation\_range\_name | The name of the cluster's secondary range used to allocate IP addresses to pods. | `string` | n/a | yes |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where Cloud Composer Environment is created. | `string` | n/a | yes |
| service\_ip\_allocation\_range\_name | The name of the services' secondary range used to allocate IP addresses to the cluster. | `string` | n/a | yes |
| subnetwork | Subetwork where Cloud Composer is created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
