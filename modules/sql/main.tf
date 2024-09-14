resource "google_sql_database_instance" "db" {
  name                = "${var.common.prefix}-eisa-db-${var.common.environment}"
  region              = var.common.region
  database_version    = "POSTGRES_15"
  deletion_protection = false
  settings {
    tier              = "db-custom-2-7680"
    activation_policy = "ALWAYS"
    ip_configuration {
      ipv4_enabled = true
    }
    disk_type = "PD_SSD"
    disk_size = 10
  }
}

resource "google_sql_database" "eisa" {
  name     = var.sql.database
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "eisa" {
  name     = var.sql.user
  instance = google_sql_database_instance.db.name
  password = var.sql.password
}