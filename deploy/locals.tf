locals {
  es_domain = "${join("", [for name in split("-", var.owner) : substr("${name}", 0, 1)])}-web-log-summary"
}
