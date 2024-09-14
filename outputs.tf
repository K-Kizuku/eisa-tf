output "cloud_run_eisa_service_url" {
  value       = module.cloud_run.eisa_service_url
  description = "The URL of the deployed Cloud Run service"
}

output "cloud_run_hoge_service_url" {
  value       = module.cloud_run.hoge_service_url
  description = "The URL of the deployed Cloud Run service"
}

output "artifact_registry_repo" {
  value       = module.registry.repository_id
  description = "The ID of the Artifact Registry repository"
}

output "storage_bucket_name" {
  value       = module.storage.bucket_name
  description = "The name of the Google Cloud Storage bucket"
}


output "wif_provider" {
  value       = "projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${module.cd.workload_identity_pool_id}/providers/${module.cd.workload_identity_pool_provider_id}"
  description = "Workload Identity Federation Provider ID"
}

output "debug" {
  value = data.google_project.project.number
}

output "wif_service_account" {
  value       = module.cd.wif_service_account
  description = "Service Account email used for GitHub Actions"
}

output "members" {
  value       = module.cloud_run.cloud_run_service_accounts
  description = "The list of service account emails"

}

output "ip_address" {
  value = module.lb.ip_address
}

