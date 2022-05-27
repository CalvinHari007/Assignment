locals {
  app_service_name        = format("%s-%s", var.app_service_name, var.env_name)
  front_service_name        = format("%s-%s", var.front_service_name, var.env_name)
  allow_authenticated = var.allow_unauth_access ? 1 : 0
  members             = var.iam_member == "" ? "allUsers" : var.iam_member
  spanner_instance_id           = format("%s-%s", var.instance_id, var.env_name)
  spanner_display_name = format("%s-%s", var.instance_display_name, var.env_name)
  display_name          = var.instance_display_name == "" ? local.instance_id : local.instance_display_name
  firestore_instance_id = format("%s-%s", var.firestore_id, var.env_name)
}

resource "google_project_service" "gcr_api" {
  service            = "containerregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "spanner_api" {
  service            = "spanner.googleapis.com"
  disable_on_destroy = false
}

# Building presentation layer - App Engine

resource "google_app_engine_standard_app_version" "front_end_v1" {
  project    = var.project_id
  version_id = var.app_version
  service    = local.front_service_name
  runtime    = var.front_runtime 

  entrypoint {
    shell = 
  }

  deployment {
    zip {
      source_url = var.source_url
    }
  }

  env_variables = {
    port = var.app_eng_port
  }

  automatic_scaling {
    max_concurrent_requests = 10
    min_idle_instances = 1
    max_idle_instances = 3
    min_pending_latency = "1s"
    max_pending_latency = "5s"
    standard_scheduler_settings {
      target_cpu_utilization = 0.5
      target_throughput_utilization = 0.75
      min_instances = 2
      max_instances = 10
    }
  }

  delete_service_on_destroy = true
}

resource "google_app_engine_firewall_rule" "rule" {
  project      = var.project_id
  priority     = 1000
  action       = "ALLOW"
  source_range = "*"
}

# Building Application/Service Tier - Cloud Run 
resource "google_cloud_run_service" "appl-tier" {
  name     = local.app_service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.container_image_path
        ports {
          container_port = var.container_port
          }
        }
      }
    }
  }


 traffic {
    percent         = 100
  }

  timeouts {
    create = var.cloud_run_timeout
    update = var.cloud_run_timeout
    delete = var.cloud_run_timeout
  }
}

output "cloud-run-url" {
    value google_cloud_run_service.appl-tier.url
}



# Builing Database Layer - Cloud Spanner and Firebase. 

resource "google_spanner_instance" "backend-db" {
  name         = local.spanner_instance_id
  config       = var.config
  display_name = local.spanner_display_name
  num_nodes    = var.num_nodes
  project      = var.project_id
  dbname       = var.spanner_dbname

  timeouts {
    create = var.spanner_instance_timeout
    update = var.spanner_instance_timeout
    delete = var.spanner_instance_timeout
  }
}

resource "google_filestore_instance" "backend-store" {
  name = local.firestore_instance_id
  location = var.region
  tier = "PREMIUM"

  file_shares {
    capacity_gb = var.storage_size
    name        = "share1"
  }

  networks {
    network = "default"
    modes   = ["MODE_IPV4"]
  }
}

