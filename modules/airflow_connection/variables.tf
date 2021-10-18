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
  type        = string
  description = "Project ID where Cloud Composer Environment is created."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create this resource or not"
}

variable "region" {
  type        = string
  description = "Region where the Cloud Composer Environment is created."
}

variable "composer_env_name" {
  type        = string
  description = "Name of the Cloud Composer Environment."
}

variable "id" {
  type        = string
  description = "The ID of the connection within Airflow"
}

variable "host" {
  type        = string
  default     = null
  description = "The optional host field of the connection"
}


variable "uri" {
  type        = string
  default     = null
  sensitive   = true
  description = "The optional uri field of the connection"
}

variable "login" {
  type        = string
  default     = null
  sensitive   = true
  description = "The optional login field of the connection"
}

variable "password" {
  type        = string
  default     = null
  sensitive   = true
  description = "The optional password field of the connection"
}

variable "port" {
  type        = string
  default     = null
  description = "The optional port field of the connection"
}

variable "schema" {
  type        = string
  default     = null
  description = "The optional schema field of the connection"
}

variable "type" {
  type        = string
  default     = null
  description = "The optional type field of the connection"
}

variable "extra" {
  type        = any
  description = "The optional exta field of the connection. If this is not a string it will be encoded as json which is useful for things like oauth tokens and gcpcloudsql"
  default     = null
  sensitive   = true
}



