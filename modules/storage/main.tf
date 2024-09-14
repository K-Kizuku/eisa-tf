# Cloud Storage Bucket
resource "google_storage_bucket" "eisa_bucket" {
  name     = "${var.common.prefix}-storage-bucket-${var.common.environment}"
  location = var.storage.location
}


# Google Cloud Storage IAM Binding (Allow access to the bucket)
resource "google_storage_bucket_iam_member" "bucket_reader" {
  bucket   = "${var.common.prefix}-storage-bucket-${var.common.environment}"
  role     = "roles/storage.objectViewer"
  for_each = toset(var.members)
  member   = each.value
}