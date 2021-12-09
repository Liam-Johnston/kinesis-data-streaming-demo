variable "region" {
  type        = string
  description = "The region to deploy this infrastructure in"
}

variable "project_name" {
  type        = string
  description = "The name of the project that this infrastructure has been built for"
}

variable "owner" {
  type        = string
  description = "The owner of the project that this infrastructure has been built for"
}

variable "ip_address" {
  type        = string
  description = "Your IP address, used to connect to the server & open search dashboard"
}
