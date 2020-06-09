# Module Cloud Composer Environment

This optional module is used to create a Cloud Composer environment.

```hcl
module "composer" {
  source = "terraform-google-modules/composer/google//modules/create_environment"

  project = "project-123"
  name    = "Composer-Prod-Env"
  region  = "us-central1"

  config {
    node_count = "3"

    node_config {
      zone         = "us-central1-f"
      machine_type = "n1-standard-1"

      network    = "test-network"
      subnetwork = "test-subnetwork"

      service_account = sa@project-id.iam.gserviceaccount.com
    }
  }
}

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| composer\_env\_name | Name of Cloud Composer Environment | string | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | string | n/a | yes |
| ip\_cidr\_range | CIDR range for the Cloud Composer Subnet. | string | `"10.0.0.0/14"` | no |
| machine\_type | Machine type of Cloud Composer nodes. | string | `"n1-standard-8"` | no |
| network\_name | Name of network created for Cloud Composer Environment. | string | `"composer-network-01"` | no |
| node\_count | Number of worker nodes in Cloud Composer Environment. | number | `"3"` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | string | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | string | `"us-central1"` | no |
| subnet\_name | Name of subnetwork created for Cloud Composer Environment. | string | `"composer-subnet-01"` | no |
| zone | Zone where the Cloud Composer nodes are created. | string | `"us-central1-f"` | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
