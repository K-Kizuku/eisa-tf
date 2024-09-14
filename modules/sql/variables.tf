variable "sql" {
  type = object({
    database = string
    password = string
    user     = string
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