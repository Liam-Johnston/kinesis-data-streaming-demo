variable "owner" {
  type = string
}

variable "region" {
  type        = string
}

variable "firehose_stream" {
  type        = string
}

variable "ip_address" {
  type        = string
  description = "Your IP address, used to connect to the server & open search dashboard"
}
