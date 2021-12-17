locals {
  user_initials = join("", [for name in split("-", var.owner) : substr(name, 0, 1)])
  project_name  = "kinesis-workshop"
}
