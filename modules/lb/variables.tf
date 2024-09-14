variable "lb" {
  type = object({
    custom_domain = string
  })
}

variable "eisa_service_url" {
  type = string
}

variable "hoge_service_url" {
  type = string
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