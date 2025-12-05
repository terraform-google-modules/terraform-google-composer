/**
 * Copyright 2022 Google LLC
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

variable "service_project_id" {
  description = "Project ID where Cloud Composer Environment is created."
  type        = string
}


variable "region" {
  description = "Region where the Cloud Composer Environment is created."
  type        = string
  default     = "us-central1"
}


variable "network" {
  type        = string
  description = "The VPC network to host the composer cluster."
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the composer cluster."
}

variable "master_ipv4_cidr" {
  description = "The CIDR block from which IP range in tenant project will be reserved for the master."
  type        = string
  default     = null
}


variable "cloud_composer_network_ipv4_cidr_block" {
  description = "The CIDR block from which IP range in tenant project will be reserved."
  type        = string
  default     = null
}


variable "gke_subnet_ip_range" {
  type        = list(string)
  description = "The GKE subnet IP range"
}

variable "gke_pods_services_ip_ranges" {
  type        = list(string)
  description = "The secondary IP ranges for the GKE Pods and Services IP ranges"
}


variable "composer_env_name" {
  description = "Name of Cloud Composer Environment"
  type        = string
}

variable "dns_zone_name" {
  description = "Composer DNS private zone name"
  type        = string
  default     = "composer-google-cloud-dns"
}

variable "dns_name" {
  description = "The DNS name of the managed zone"
  type        = string
  default     = "composer.cloud.google.com."
}

variable "composer_sa_name" {
  description = "Service Account name to be used for running Cloud Composer Environment."
  type        = string
  default     = "composer-sa"
}

variable "enable_firewall_logging" {
  description = "Enable logging for firewall rules"
  type        = bool
  default     = true
}

variable "firewall_logging_metadata" {
  description = "The logging metadata to include in firewall logs. Options: INCLUDE_ALL_METADATA or EXCLUDE_ALL_METADATA"
  type        = string
  default     = "INCLUDE_ALL_METADATA"

  validation {
    condition     = contains(["INCLUDE_ALL_METADATA", "EXCLUDE_ALL_METADATA"], var.firewall_logging_metadata)
    error_message = "firewall_logging_metadata must be either 'INCLUDE_ALL_METADATA' or 'EXCLUDE_ALL_METADATA'."
  }
}
