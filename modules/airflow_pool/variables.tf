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

variable "project" {
  type        = string
  description = "Project name where Cloud Composer Environment is created."
}

variable "region" {
  type        = string
  description = "Region where the Cloud Composer Environment is created."
}

variable "composer_env_name" {
  type        = string
  description = "Name of the Cloud Composer Environment."
}

variable "pool_name" {
  type        = string
  description = "The name of the pool"
}

variable "slot_count" {
  type        = number
  description = "The number of slots in this pool"
}

variable "include_deferred" {
  type        = bool
  default     = false
  description = "Whether the pool should include deferred tasks in its calculation of occupied slots"
}

variable "description" {
  type        = string
  description = "The description of the pool"
  default     = "Managed by Terraform"
}
