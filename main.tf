data "google_project" "project" {
  project_id = var.common.project
}

module "cloud_run" {
  source = "./modules/cloudrun"
  common = var.common
}

module "lb" {
  source           = "./modules/lb"
  common           = var.common
  lb               = var.lb
  eisa_service_url = module.cloud_run.cloudrun_neg1
  hoge_service_url = module.cloud_run.cloudrun_neg2
}


module "sql" {
  source = "./modules/sql"
  common = var.common
  sql    = var.sql
}

module "storage" {
  source  = "./modules/storage"
  common  = var.common
  storage = var.storage
  members = module.cloud_run.cloud_run_service_accounts
}

module "registry" {
  source  = "./modules/registry"
  common  = var.common
  members = module.cloud_run.cloud_run_service_accounts
}

module "cd" {
  source              = "./modules/cd"
  common              = var.common
  github_repositories = var.github_repositories
}