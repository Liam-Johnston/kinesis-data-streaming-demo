variable "owner" {
  type        = string
  description = "The owner of the project that this infrastructure has been built for"
}

variable "region" {
  type = string
}

variable "project_name" {
  type        = string
  description = "The name of the project that this infrastructure has been built for"
}

variable "domain_name" {
  type = string
}

variable "delivery_firehose_role_arn" {
  type = string
}

variable "delivery_firehose_role_name" {
  type = string
}
