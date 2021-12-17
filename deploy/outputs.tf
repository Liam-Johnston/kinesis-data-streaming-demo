output "backend_role_for_elastic_search" {
  value = aws_iam_role.es_delivery_role.arn
}

output "add_backend_role_here" {
  value = "https://${module.elastic_search_cluser.kibana_endpoint}app/opendistro_security#/roles/view/all_access"
}
