# Simple Cloud Composer Environment (V2) Example

This example illustrates how to use the `composer` V2 module to deploy private composer environment with private GKE cluster, CloudSql instance and use private service connect (PSC) endpoint to connect to CloudSql instance. `use_private_environment` and `enable_private_endpoint` needs to be `true` to deploy private GKE cluster and CloudSql instance. `cloud_composer_connection_subnetwork` value will result in PSC endpoint for CloudSql instance.

This example also creates a Cloud Storage Bucket for scheduled snapshots and assign appropriate permission(s) to Composer Service Account on the bucket.

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
| subnetwork | Name of the Subetwork where Cloud Composer is created. | `string` | n/a | yes |
| subnetwork\_self\_link | self\_link of the Subetwork where Cloud Composer is created. | `string` | n/a | yes |

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
