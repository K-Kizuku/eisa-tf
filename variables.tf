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

variable "lb" {
  type = object({
    custom_domain = string
  })
}

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


variable "storage" {
  type = object({
    location = string
  })
}

variable "sql" {
  type = object({
    database = string
    password = string
    user     = string
  })
}

variable "github_repositories" {
  description = "List of GitHub repositories in the format owner/repo"
  type        = list(string)
}