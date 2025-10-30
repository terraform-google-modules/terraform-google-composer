/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Project ID where Cloud Composer Environment is created."
  type        = string
}

variable "composer_env_name" {
  description = "Name of Cloud Composer Environment"
  type        = string
}

variable "region" {
  description = "Region where the Cloud Composer Environment is created."
  type        = string
  default     = "us-central1"
}

variable "labels" {
  type        = map(string)
  description = "The resource labels (a map of key/value pairs) to be applied to the Cloud Composer."
  default     = {}
}

variable "tags" {
  description = "Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls."
  type        = set(string)
  default     = []
}

variable "network" {
  type        = string
  description = "The VPC network to host the composer cluster."
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "subnetwork" {
  type        = string
  description = "The name of the subnetwork to host the composer cluster."
}

variable "subnetwork_region" {
  type        = string
  description = "The subnetwork region of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "create_network_attachment" {
  type        = bool
  description = "Either create a new network attachment or use existing one. If true, provide the subnet details."
  default     = true
}

variable "composer_network_attachment_name" {
  type        = string
  description = "Name for PSC (Private Service Connect) Network entry point."
  default     = null
}

variable "composer_service_account" {
  description = "Service Account for running Cloud Composer."
  type        = string
  default     = null
}

variable "airflow_config_overrides" {
  type        = map(string)
  description = "Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example \"core-dags_are_paused_at_creation\"."
  default     = {}
}

variable "env_variables" {
  type        = map(string)
  description = "Variables of the airflow environment."
  default     = {}
}

variable "image_version" {
  type        = string
  description = "The version of the aiflow running in the cloud composer environment."
  default     = "composer-3-airflow-2.10.2-build.7"
}

variable "web_server_plugins_mode" {
  type        = string
  description = "Web server plugins configuration. Can be either 'ENABLED' or 'DISABLED'. Defaults to 'ENABLED'."
  default     = "ENABLED"
}

variable "pypi_packages" {
  type        = map(string)
  description = " Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. \"numpy\")."
  default     = {}
}

variable "use_private_environment" {
  description = "Create a private environment. If true, a private Composer environment will be created."
  type        = bool
  default     = false
}

variable "enable_private_builds_only" {
  type        = bool
  description = "If true, builds performed during operations that install Python packages have only private connectivity to Google services. If false, the builds also have access to the internet."
  default     = false
}

variable "maintenance_start_time" {
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
  type        = string
  default     = "05:00"
}

variable "maintenance_end_time" {
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
  type        = string
  default     = null
}

variable "maintenance_recurrence" {
  description = "Frequency of the recurring maintenance window in RFC5545 format."
  type        = string
  default     = null
}

variable "environment_size" {
  type        = string
  description = "The environment size controls the performance parameters of the managed Cloud Composer infrastructure that includes the Airflow database. Values for environment size are: `ENVIRONMENT_SIZE_SMALL`, `ENVIRONMENT_SIZE_MEDIUM`, and `ENVIRONMENT_SIZE_LARGE`."
  default     = "ENVIRONMENT_SIZE_MEDIUM"
}

variable "scheduler" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    count      = number
  })
  default = {
    cpu        = 1
    memory_gb  = 4
    storage_gb = 5
    count      = 2
  }
  description = "Configuration for resources used by Airflow schedulers."
}

variable "web_server" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
  }
  description = "Configuration for resources used by Airflow web server."
}

variable "worker" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    min_count  = number
    max_count  = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
    min_count  = 2
    max_count  = 6
  }
  description = "Configuration for resources used by Airflow workers."
}

variable "triggerer" {
  type = object({
    cpu       = string
    memory_gb = number
    count     = number
  })
  default     = null
  description = " Configuration for resources used by Airflow triggerer"
}

variable "dag_processor" {
  type = object({
    cpu        = string
    memory_gb  = number
    storage_gb = number
    count      = number
  })
  default = {
    cpu        = 2
    memory_gb  = 7.5
    storage_gb = 5
    count      = 2
  }
  description = "Configuration for resources used by Airflow workers."
}

variable "grant_sa_agent_permission" {
  type        = bool
  default     = true
  description = "Cloud Composer relies on Workload Identity as Google API authentication mechanism for Airflow. "
}

variable "scheduled_snapshots_config" {
  type = object({
    enabled                    = optional(bool, false)
    snapshot_location          = optional(string)
    snapshot_creation_schedule = optional(string)
    time_zone                  = optional(string)
  })
  default     = null
  description = "The recovery configuration settings for the Cloud Composer environment"
}

variable "storage_bucket" {
  description = "Name of an existing Cloud Storage bucket to be used by the environment"
  type        = string
  default     = null
}

variable "resilience_mode" {
  description = "Cloud Composer 2.1.15 or newer only. The resilience mode states whether high resilience is enabled for the environment or not. Values for resilience mode are `HIGH_RESILIENCE` for high resilience and `STANDARD_RESILIENCE` for standard resilience"
  type        = string
  default     = null
}

variable "cloud_data_lineage_integration" {
  description = "Whether or not Dataplex data lineage integration is enabled. Cloud Composer environments in versions composer-2.1.2-airflow-..* and newer)"
  type        = bool
  default     = false
}

variable "web_server_network_access_control" {
  type = list(object({
    allowed_ip_range = string
    description      = string
  }))
  default     = null
  description = "The network-level access control policy for the Airflow web server. If unspecified, no network-level access restrictions are applied"
}

variable "kms_key_name" {
  description = "Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key."
  type        = string
  default     = null
}

variable "task_logs_retention_storage_mode" {
  description = "The mode of storage for Airflow workers task logs. Values for storage mode are CLOUD_LOGGING_ONLY to only store logs in cloud logging and CLOUD_LOGGING_AND_CLOUD_STORAGE to store logs in cloud logging and cloud storage. Cloud Composer 2.0.23 or newer only"
  type        = string
  default     = null
}
