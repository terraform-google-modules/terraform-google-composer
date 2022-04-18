/**
 * Copyright 2020 Google LLC
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
}

variable "zone" {
  description = "Zone where the Cloud Composer Environment is created."
  type        = string
}

variable "network" {
  description = "Network where Cloud Composer is created."
  type        = string
}

variable "subnetwork" {
  description = "Subetwork where Cloud Composer is created."
  type        = string
}

variable "enable_private_endpoint" {
  description = "Configure public access to the cluster endpoint."
  type        = bool
  default     = false
}
