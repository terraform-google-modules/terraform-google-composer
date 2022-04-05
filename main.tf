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

module "composer-environment" {
  source = "./modules/create_environment_v1"

  project_id              = var.project_id
  composer_env_name       = var.composer_env_name
  region                  = var.region
  zone                    = var.zone
  network                 = var.network
  subnetwork              = var.subnetwork
  enable_private_endpoint = var.enable_private_endpoint
}
