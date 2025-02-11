# Simple Cloud Composer Environment (V3) Example

This example illustrates how to use the `composer` V2 module to deploy private composer environment with private service connect (PSC) endpoint to connect network attachments.

This example also creates a Cloud Storage Bucket for scheduled snapshots and assign appropriate permission(s) to Composer Service Account on the bucket.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of Cloud Composer Environment. | `string` | `"ci-composer"` | no |
| composer\_sa | Service Account to be used for running Cloud Composer Environment. | `string` | n/a | yes |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where Cloud Composer Environment is created. | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| project\_id | Project ID where Cloud Composer Environment is created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
