# terraform-google-composer

This module makes it easy to create a Cloud Composer Environment. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCP Composer Environment

## Usage

Basic usage of this module is as follows:

```hcl
module "composer" {
  source  = "terraform-google-modules/composer/google"
  version = "~> 2.0"

  project_id        = "<PROJECT ID>"
  region            = "us-central1"
  composer_env_name = "composer-env-test"
  network           = "test-network"
  subnetwork        = "composer-subnet"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| network | Network where Cloud Composer is created. | `string` | n/a | yes |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | n/a | yes |
| subnetwork | Subetwork where Cloud Composer is created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | The name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Project Editor: `roles/editor`
- Network Admin: `roles/compute.networkAdmin`
- Instance Admin: `roles/compute.instanceAdmin.v1`
- Service Account User: `roles/iam.serviceAccountUser`
- Composer Worker: `roles/composer.worker`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Cloud Composer API: `composer.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
