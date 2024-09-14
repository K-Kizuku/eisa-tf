locals {
  members = [
    "serviceAccount:${google_cloud_run_service.hoge_cloud_run_service.name}@${google_cloud_run_service.hoge_cloud_run_service.project}.iam.gserviceaccount.com",
    "serviceAccount:${google_cloud_run_service.eisa_cloud_run_service.name}@${google_cloud_run_service.eisa_cloud_run_service.project}.iam.gserviceaccount.com",
  ]
}