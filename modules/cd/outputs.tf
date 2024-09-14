

output "workload_identity_pool_id" {
  value       = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
  description = "Workload Identity Pool ID"
}

output "workload_identity_pool_provider_id" {
  value       = google_iam_workload_identity_pool_provider.github_actions_provider.workload_identity_pool_provider_id
  description = "Workload Identity Pool Provider ID"
}

output "wif_service_account" {
  value       = google_service_account.github_actions_service_account.email
  description = "Service Account email used for GitHub Actions"
}