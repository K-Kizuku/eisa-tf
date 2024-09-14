# Workload Identity Poolの作成
resource "google_iam_workload_identity_pool" "github_actions_pool" {
  provider                  = google
  project                   = var.common.project
  workload_identity_pool_id = "github-actions-pool-1"
  display_name              = "GitHub Actions WIP"
}

# Workload Identity Pool Provider の作成
resource "google_iam_workload_identity_pool_provider" "github_actions_provider" {
  provider                           = google
  project                            = var.common.project
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider"
  display_name                       = "GitHub Actions Provider"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"        # サブジェクトからリポジトリ情報を取得
    "attribute.actor"      = "assertion.actor"      # 実行者情報
    "attribute.repository" = "assertion.repository" # リポジトリ情報をマッピング
  }
  depends_on = [
    google_project_iam_member.artifact_registry_pusher,
    google_project_iam_member.cloud_run_admin,
    google_project_iam_member.cloud_run_developer,
    google_project_iam_member.service_account_user,
    google_service_account.github_actions_service_account,
    google_service_account_iam_member.allow_github_actions_multiple_repos
  ]
}

# サービスアカウントの作成
resource "google_service_account" "github_actions_service_account" {
  account_id   = "${var.common.prefix}-github-actions-sa"
  display_name = "GitHub Actions Service Account"
}

# Workload Identity FederationでGitHub Actionsが使用できるようにIAMポリシーを設定
resource "google_service_account_iam_member" "allow_github_actions_multiple_repos" {
  service_account_id = google_service_account.github_actions_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  # `assertion.sub` に含まれるリポジトリを使用
  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions_pool.name}/attribute.repository/${join(",", var.github_repositories)}"
}





# サービスアカウントにArtifact Registryの書き込み権限を付与
resource "google_project_iam_member" "artifact_registry_pusher" {
  project = var.common.project
  role    = "roles/artifactregistry.writer" # アーティファクトのアップロード権限
  member  = "serviceAccount:${google_service_account.github_actions_service_account.email}"
}

# サービスアカウントにCloud Run管理者権限を付与
resource "google_project_iam_member" "cloud_run_admin" {
  project = var.common.project
  role    = "roles/run.admin" # Cloud Runサービスの管理権限
  member  = "serviceAccount:${google_service_account.github_actions_service_account.email}"
}

# サービスアカウントにCloud Run参照権限を付与
resource "google_project_iam_member" "cloud_run_developer" {
  project = var.common.project
  role    = "roles/run.developer" # Cloud Runリソースの参照権限
  member  = "serviceAccount:${google_service_account.github_actions_service_account.email}"
}

# サービスアカウントにService Account Userロールを付与
resource "google_project_iam_member" "service_account_user" {
  project = var.common.project
  role    = "roles/iam.serviceAccountUser" # actAs権限を含むロール
  member  = "serviceAccount:${google_service_account.github_actions_service_account.email}"
}