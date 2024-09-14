variable "cloud_run" {
  type = object({
    cpu    = string
    memory = string
  })
  default = {
    cpu    = "1"
    memory = "512Mi"
  }
}

variable "service_name" {
  type    = string
  default = "eisa-app"
}

variable "common" {
  type = object({
    project     = string
    region      = string
    prefix      = string
    zone        = string
    environment = string
  })
  description = "Common variables for all environments"
}