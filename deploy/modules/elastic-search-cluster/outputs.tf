output "domain_arn" {
  value = aws_elasticsearch_domain.this.arn
}

output "kibana_endpoint" {
  value = aws_elasticsearch_domain.this.kibana_endpoint
}
