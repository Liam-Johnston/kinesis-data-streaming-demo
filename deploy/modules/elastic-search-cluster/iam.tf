data "aws_iam_policy_document" "es_access_policy" {
  statement {
    sid     = "OpenSearchUserAccess"
    actions = ["es:*"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["${aws_elasticsearch_domain.this.arn}/*"]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = [local.my_ip]
    }
  }

  statement {
    sid     = "FirehoseAccess"
    actions = ["es:*"]
    effect  = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.delivery_firehose_role_arn]
    }
    resources = ["${aws_elasticsearch_domain.this.arn}/*"]
  }
}

resource "aws_elasticsearch_domain_policy" "es_access_policy" {
  domain_name     = var.domain_name
  access_policies = data.aws_iam_policy_document.es_access_policy.json
}

data "aws_iam_policy_document" "es_delivery" {
  statement {
    sid = "ESGetConfig"
    actions = [
      "es:ESHttpGet"
    ]
    resources = [
      "${aws_elasticsearch_domain.this.arn}/_all/_settings",
      "${aws_elasticsearch_domain.this.arn}/_cluster/stats",
      "${aws_elasticsearch_domain.this.arn}/_mapping/test",
      "${aws_elasticsearch_domain.this.arn}/_nodes",
      "${aws_elasticsearch_domain.this.arn}/_nodes/*/stats",
      "${aws_elasticsearch_domain.this.arn}/_stats",
      "${aws_elasticsearch_domain.this.arn}/test/_stats"
    ]
  }

  statement {
    sid = "ESDelivery"
    actions = [
      "es:DescribeElasticsearchDomain",
      "es:DescribeElasticsearchDomains",
      "es:DescribeElasticsearchDomainConfig",
      "es:ESHttpPost",
      "es:ESHttpPut"
    ]
    resources = [
      "${aws_elasticsearch_domain.this.arn}",
      "${aws_elasticsearch_domain.this.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "es_delivery" {
  name   = "${var.owner}-es-delivery"
  policy = data.aws_iam_policy_document.es_delivery.json
}

resource "aws_iam_role_policy_attachment" "attach_es_policy" {
  role       = var.delivery_firehose_role_name
  policy_arn = aws_iam_policy.es_delivery.arn
}
