
variable "storage" {
  type = object({
    location = string
  })
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

variable "custom_domain" {
  type = string
  
}

variable "members" {
  type = list(string)
}