variable "region" {
  type        = string
  description = "The region to deploy this infrastructure in"
}

variable "owner" {
  type        = string
  description = "The owner of the project that this infrastructure has been built for"

  validation {
    condition     = length(regexall("^[a-z]+-[a-z]+$", var.owner)) > 0
    error_message = "Invalid value for owner, please follow the format: <FIRST_NAME>-<LAST_NAME>. e.g. liam-johnston."
  }
}
