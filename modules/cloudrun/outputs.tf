output "eisa_service_location" {
  value = google_cloud_run_service.eisa_cloud_run_service.location
}

output "eisa_service_project" {
  value = google_cloud_run_service.eisa_cloud_run_service.project
}

output "eisa_service_name" {
  value = google_cloud_run_service.eisa_cloud_run_service.name
}

output "eisa_service_url" {
  value = google_cloud_run_service.eisa_cloud_run_service.status[0].url
}

output "hoge_service_location" {
  value = google_cloud_run_service.hoge_cloud_run_service.location
}

output "hoge_service_project" {
  value = google_cloud_run_service.hoge_cloud_run_service.project
}

output "hoge_service_name" {
  value = google_cloud_run_service.hoge_cloud_run_service.name
}

output "hoge_service_url" {
  value = google_cloud_run_service.hoge_cloud_run_service.status[0].url
}

output "cloud_run_service_accounts" {
  value = local.members
}

output "cloud_run_eisa_service_url" {
  value = "projects/${google_cloud_run_service.eisa_cloud_run_service.project}/locations/${google_cloud_run_service.eisa_cloud_run_service.location}/services/${google_cloud_run_service.eisa_cloud_run_service.name}"
}

output "cloud_run_hoge_service_url" {
  value = "projects/${google_cloud_run_service.hoge_cloud_run_service.project}/locations/${google_cloud_run_service.hoge_cloud_run_service.location}/services/${google_cloud_run_service.hoge_cloud_run_service.name}"
}

output "cloudrun_neg1" {
  value = google_compute_region_network_endpoint_group.cloudrun_neg1.id
}

output "cloudrun_neg2" {
  value = google_compute_region_network_endpoint_group.cloudrun_neg2.id
}