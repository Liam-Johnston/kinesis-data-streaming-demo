variable "region" {
  type        = string
  description = "The region to deploy this infrastructure in"
}

variable "ssh_key_name" {
  type        = string
  description = "Existing SSH key pair added to instances"
}

variable "project_name" {
  type        = string
  description = "The name of the project that this infrastructure has been built for"
}

variable "owner" {
  type        = string
  description = "The owner of the project that this infrastructure has been built for"
}
