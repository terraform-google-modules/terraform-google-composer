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

locals {
  network_project_id = var.network_project_id != "" ? var.network_project_id : var.project_id
  subnetwork_region  = var.subnetwork_region != "" ? var.subnetwork_region : var.region
  cloud_composer_sa  = format("service-%s@cloudcomposer-accounts.iam.gserviceaccount.com", data.google_project.project.number)
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

    enable_private_environment = var.use_private_environment # reusing the existing variable name from previous versions
    enable_private_builds_only = var.enable_private_builds_only

    environment_size = var.environment_size
    resilience_mode  = var.resilience_mode

    node_config {
      service_account             = var.composer_service_account
      tags                        = var.tags
      network                     = var.create_network_attachment ? "projects/${local.network_project_id}/global/networks/${var.network}" : null
      subnetwork                  = var.create_network_attachment ? "projects/${local.network_project_id}/regions/${local.subnetwork_region}/subnetworks/${var.subnetwork}" : null
      composer_network_attachment = var.create_network_attachment ? null : "projects/{var.project_id}/regions/${var.region}/networkAttachments/${var.composer_network_attachment_name}"
    }

    dynamic "software_config" {
      for_each = [
        {
          airflow_config_overrides = var.airflow_config_overrides
          pypi_packages            = var.pypi_packages
          env_variables            = var.env_variables
          image_version            = var.image_version
          web_server_plugins_mode  = var.web_server_plugins_mode
      }]
      content {
        airflow_config_overrides = software_config.value["airflow_config_overrides"]
        pypi_packages            = software_config.value["pypi_packages"]
        env_variables            = software_config.value["env_variables"]
        image_version            = software_config.value["image_version"]
        web_server_plugins_mode  = software_config.value["web_server_plugins_mode"]
        dynamic "cloud_data_lineage_integration" {
          for_each = var.cloud_data_lineage_integration ? ["cloud_data_lineage_integration"] : []
          content {
            enabled = var.cloud_data_lineage_integration
          }
        }
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

      dynamic "dag_processor" {
        for_each = var.dag_processor != null ? [var.dag_processor] : []
        content {
          cpu        = dag_processor.value["cpu"]
          memory_gb  = dag_processor.value["memory_gb"]
          storage_gb = dag_processor.value["storage_gb"]
          count      = dag_processor.value["count"]
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

    dynamic "data_retention_config" {
      for_each = var.task_logs_retention_storage_mode == null ? [] : ["data_retention_config"]
      content {
        task_logs_retention_config {
          storage_mode = var.task_logs_retention_storage_mode
        }
      }
    }
  }

  depends_on = [google_project_iam_member.composer_agent_service_account]

}
