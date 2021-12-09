resource "aws_elasticsearch_domain_policy" "es_access_policy" {
  domain_name = var.domain_name
  access_policies = data.aws_iam_policy_document.es_access_policy.json
}

data "aws_iam_policy_document" "es_access_policy" {
  statement {
      sid     = "OpenSearchUserAccess"

      actions = ["es:*"]

      principals {
        type = "AWS"
        identifiers = ["*"]
      }

      effect = "Allow"
      resources = ["${aws_elasticsearch_domain.this.arn}/*"]

      condition {
        test      = "IpAddress"
        variable  = "aws:SourceIp"
        values    = [var.ip_address]
      }
  }
}
