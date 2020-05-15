/**
 * Copyright 2019 Google LLC
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

variable "zone" {
  description = "Zone where the Cloud Composer nodes are created."
  type        = string
  default     = "us-central1-f"
}

variable "node_count" {
  description = "Number of worker nodes in Cloud Composer Environment."
  type        = string
  default     = "3"
}

variable "machine_type" {
  description = "Machine type of Cloud Composer nodes."
  type        = string
  default     = "n1-standard-8"
}

variable "network_name" {
  description = "Name of network created for Cloud Composer Environment."
  type        = string
  default     = "composer-network-01"
}

variable "subnet_name" {
  description = "Name of subnetwork created for Cloud Composer Environment."
  type        = string
  default     = "composer-subnet-01"
}

variable "ip_cidr_range" {
  description = "CIDR range for the Cloud Composer Subnet."
  type        = string
  default     = "10.0.0.0/14"
}

variable "composer_service_account" {
  description = "Service Account for creating Cloud Composer."
  type        = string
}
