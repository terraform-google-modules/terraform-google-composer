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

locals {
  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id
  subnetwork_region  = var.subnetwork_region != "" ? var.subnetwork_region : var.region
  cloud_composer_sa  = format("service-%s@cloudcomposer-accounts.iam.gserviceaccount.com", data.google_project.project.number)

  master_authorized_networks_config = length(var.master_authorized_networks) == 0 ? [] : [{
    cidr_blocks : var.master_authorized_networks
  }]
}

resource "google_composer_environment" "composer_env" {
  provider = google-beta

  project = var.project_id
  name    = var.composer_env_name
  region  = var.region
  labels  = var.labels

  dynamic "storage_config" {
    for_each = var.storage_bucket != null ? ["storage_config"] : []
    content {
      bucket = var.storage_bucket
    }
  }

  config {

    environment_size = var.environment_size
    resilience_mode  = var.resilience_mode

    node_config {
      network              = "projects/${local.network_project_id}/global/networks/${var.network}"
      subnetwork           = "projects/${local.network_project_id}/regions/${local.subnetwork_region}/subnetworks/${var.subnetwork}"
      service_account      = var.composer_service_account
      tags                 = var.tags
      enable_ip_masq_agent = var.enable_ip_masq_agent

      dynamic "ip_allocation_policy" {
        for_each = (var.pod_ip_allocation_range_name != null || var.service_ip_allocation_range_name != null) ? [1] : []
        content {
          cluster_secondary_range_name  = var.pod_ip_allocation_range_name
          services_secondary_range_name = var.service_ip_allocation_range_name
        }
      }
    }

    dynamic "software_config" {
      for_each = [
        {
          airflow_config_overrides = var.airflow_config_overrides
          pypi_packages            = var.pypi_packages
          env_variables            = var.env_variables
          image_version            = var.image_version
      }]
      content {
        airflow_config_overrides = software_config.value["airflow_config_overrides"]
        pypi_packages            = software_config.value["pypi_packages"]
        env_variables            = software_config.value["env_variables"]
        image_version            = software_config.value["image_version"]
        dynamic "cloud_data_lineage_integration" {
          for_each = var.cloud_data_lineage_integration ? ["cloud_data_lineage_integration"] : []
          content {
            enabled = var.cloud_data_lineage_integration
          }
        }
      }
    }

    dynamic "private_environment_config" {
      for_each = var.use_private_environment ? [
        {
          enable_private_endpoint                = var.enable_private_endpoint
          master_ipv4_cidr_block                 = var.master_ipv4_cidr
          cloud_sql_ipv4_cidr_block              = var.cloud_sql_ipv4_cidr
          cloud_composer_network_ipv4_cidr_block = var.cloud_composer_network_ipv4_cidr_block
          cloud_composer_connection_subnetwork   = var.cloud_composer_connection_subnetwork
      }] : []
      content {
        enable_private_endpoint                = private_environment_config.value["enable_private_endpoint"]
        master_ipv4_cidr_block                 = private_environment_config.value["master_ipv4_cidr_block"]
        cloud_sql_ipv4_cidr_block              = private_environment_config.value["cloud_sql_ipv4_cidr_block"]
        cloud_composer_network_ipv4_cidr_block = private_environment_config.value["cloud_composer_network_ipv4_cidr_block"]
        cloud_composer_connection_subnetwork   = private_environment_config.value["cloud_composer_connection_subnetwork"]
      }
    }

    dynamic "maintenance_window" {
      for_each = (var.maintenance_end_time != null && var.maintenance_recurrence != null) ? [
        {
          start_time = var.maintenance_start_time
          end_time   = var.maintenance_end_time
          recurrence = var.maintenance_recurrence
      }] : []
      content {
        start_time = maintenance_window.value["start_time"]
        end_time   = maintenance_window.value["end_time"]
        recurrence = maintenance_window.value["recurrence"]
      }
    }

    workloads_config {

      dynamic "scheduler" {
        for_each = var.scheduler != null ? [var.scheduler] : []
        content {
          cpu        = scheduler.value["cpu"]
          memory_gb  = scheduler.value["memory_gb"]
          storage_gb = scheduler.value["storage_gb"]
          count      = scheduler.value["count"]
        }
      }

      dynamic "web_server" {
        for_each = var.web_server != null ? [var.web_server] : []
        content {
          cpu        = web_server.value["cpu"]
          memory_gb  = web_server.value["memory_gb"]
          storage_gb = web_server.value["storage_gb"]
        }
      }

      dynamic "worker" {
        for_each = var.worker != null ? [var.worker] : []
        content {
          cpu        = worker.value["cpu"]
          memory_gb  = worker.value["memory_gb"]
          storage_gb = worker.value["storage_gb"]
          min_count  = worker.value["min_count"]
          max_count  = worker.value["max_count"]
        }
      }

      dynamic "triggerer" {
        for_each = var.triggerer != null ? [var.triggerer] : []
        content {
          cpu       = triggerer.value["cpu"]
          memory_gb = triggerer.value["memory_gb"]
          count     = triggerer.value["count"]
        }
      }

    }

    dynamic "master_authorized_networks_config" {
      for_each = local.master_authorized_networks_config
      content {
        enabled = length(var.master_authorized_networks) > 0
        dynamic "cidr_blocks" {
          for_each = master_authorized_networks_config.value["cidr_blocks"]
          content {
            cidr_block   = cidr_blocks.value["cidr_block"]
            display_name = cidr_blocks.value["display_name"]
          }
        }
      }
    }

    dynamic "recovery_config" {
      for_each = var.scheduled_snapshots_config != null ? ["recovery_config"] : []
      content {
        dynamic "scheduled_snapshots_config" {
          for_each = var.scheduled_snapshots_config != null ? [var.scheduled_snapshots_config] : []
          content {
            enabled                    = scheduled_snapshots_config.value["enabled"]
            snapshot_location          = scheduled_snapshots_config.value["snapshot_location"]
            snapshot_creation_schedule = scheduled_snapshots_config.value["snapshot_creation_schedule"]
            time_zone                  = scheduled_snapshots_config.value["time_zone"]
          }
        }
      }
    }

    dynamic "web_server_network_access_control" {
      for_each = var.web_server_network_access_control == null ? [] : ["web_server_network_access_control"]
      content {
        dynamic "allowed_ip_range" {
          for_each = { for x in var.web_server_network_access_control : x.allowed_ip_range => x }
          content {
            value       = allowed_ip_range.value["allowed_ip_range"]
            description = allowed_ip_range.value["description"]
          }
        }
      }
    }

    dynamic "encryption_config" {
      for_each = var.kms_key_name != null ? ["encryption_config"] : []
      content {
        kms_key_name = var.kms_key_name
      }
    }

  }

  depends_on = [google_project_iam_member.composer_agent_service_account]

}
