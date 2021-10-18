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
| airflow\_config\_overrides | Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example "core-dags\_are\_paused\_at\_creation". | `map(string)` | `{}` | no |
| airflow\_connections | A map of IDs to airflow connections. See the modules/airflow\_connection for a complete list of fields | `any` | `{}` | no |
| airflow\_pools | A map of IDs to airflow pool configurations. See the modules/airflow\_pool for a complete list of fields | `any` | `{}` | no |
| cloud\_sql\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for Cloud SQL. | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| disk\_size | The disk size for nodes. | `string` | `"100"` | no |
| enable\_private\_endpoint | Configure public access to the cluster endpoint. | `bool` | `false` | no |
| env\_variables | Variables of the airflow environment. | `map(string)` | `{}` | no |
| image\_version | The version of the aiflow running in the cloud composer environment. | `string` | `null` | no |
| kms\_key\_name | Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key. | `string` | `null` | no |
| labels | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `map(string)` | `{}` | no |
| machine\_type | Machine type of Cloud Composer nodes. | `string` | `"n1-standard-8"` | no |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the master. | `string` | `null` | no |
| network | Network where Cloud Composer is created. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| node\_count | Number of worker nodes in Cloud Composer Environment. | `number` | `3` | no |
| oauth\_scopes | Google API scopes to be made available on all node. | `set(string)` | <pre>[<br>  "https://www.googleapis.com/auth/cloud-platform"<br>]</pre> | no |
| pod\_ip\_allocation\_range\_name | The name of the cluster's secondary range used to allocate IP addresses to pods. | `string` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. "numpy"). | `map(string)` | `{}` | no |
| python\_version | The default version of Python used to run the Airflow scheduler, worker, and webserver processes. | `string` | `"3"` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | n/a | yes |
| service\_ip\_allocation\_range\_name | The name of the services' secondary range used to allocate IP addresses to the cluster. | `string` | `null` | no |
| subnetwork | Subetwork where Cloud Composer is created. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| tags | Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `set(string)` | `[]` | no |
| use\_ip\_aliases | Enable Alias IPs in the GKE cluster. If true, a VPC-native cluster is created. | `bool` | `false` | no |
| web\_server\_allowed\_ip\_ranges | Control access to the frontend. If null, no network-level access restrictions will be applied. | <pre>list(object({<br>    value       = string,<br>    description = string<br>  }))</pre> | `null` | no |
| web\_server\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the web server. | `string` | `null` | no |
| zone | Zone where the Cloud Composer nodes are created. | `string` | `"us-central1-f"` | no |

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
