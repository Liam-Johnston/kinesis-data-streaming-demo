variable "owner" {
  type        = string
  description = "The owner of the project that this infrastructure has been built for"
}

variable "ip_address" {
  type        = string
  description = "Your IP address, used to connect to the server & open search dashboard"
}

variable "region" {
  type        = string
}

variable "project_name" {
  type        = string
  description = "The name of the project that this infrastructure has been built for"
}

variable "domain_name" {
  type = string
}
