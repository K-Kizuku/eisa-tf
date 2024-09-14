# Cloud Run Service
resource "google_cloud_run_service" "eisa_cloud_run_service" {
  name     = "${var.common.prefix}-eisa-${var.common.environment}"
  location = var.common.region

  template {
    spec {
      containers {
        image = "${var.common.region}-docker.pkg.dev/${var.common.project}/${var.common.prefix}-docker-${var.common.environment}/${var.service_name}:latest"
        resources {
          limits = {
            cpu    = var.cloud_run.cpu
            memory = var.cloud_run.memory
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_cloud_run_service_iam_member.eisa_invoker]
}

resource "google_cloud_run_service" "hoge_cloud_run_service" {
  name     = "${var.common.prefix}-hoge-${var.common.environment}"
  location = var.common.region

  template {
    spec {
      containers {
        image = "${var.common.region}-docker.pkg.dev/${var.common.project}/${var.common.prefix}-docker-${var.common.environment}/${var.service_name}:latest"
        resources {
          limits = {
            cpu    = var.cloud_run.cpu
            memory = var.cloud_run.memory
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_cloud_run_service_iam_member.hoge_invoker]
}

resource "google_compute_region_network_endpoint_group" "cloudrun_neg1" {
  name                  = "${var.common.prefix}-cloud-run-neg11"
  region                = var.common.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_service.eisa_cloud_run_service.name
  }
}
resource "google_compute_region_network_endpoint_group" "cloudrun_neg2" {
  name                  = "${var.common.prefix}-cloud-run-neg22"
  region                = var.common.region
  network_endpoint_type = "SERVERLESS"

  cloud_run {
    service = google_cloud_run_service.hoge_cloud_run_service.name
  }
}

# Cloud Run IAM Binding (Allow all users to invoke the service)
resource "google_cloud_run_service_iam_member" "eisa_invoker" {
  location = var.common.region
  project  = var.common.project
  service  = var.service_name

  role   = "roles/run.invoker"
  member = "allUsers"
}

# Cloud Run IAM Binding (Allow all users to invoke the service)
resource "google_cloud_run_service_iam_member" "hoge_invoker" {
  location = var.common.region
  project  = var.common.project
  service  = var.service_name

  role   = "roles/run.invoker"
  member = "allUsers"
}

resource "google_service_account" "cloudrun_service_account-hoge" {
  account_id   = "${var.common.prefix}-eisa-${var.common.environment}"
  display_name = "Cloud Run Service Account"
}

resource "google_service_account" "cloudrun_service_account-eisa" {
  account_id   = "${var.common.prefix}-hoge-${var.common.environment}"
  display_name = "Cloud Run Service Account"
}

# resource "google_project_iam_binding" "cloud_run_invoker" {
#   project = var.common.project
#   role    = "roles/run.invoker"
#   members = local.members
# }



