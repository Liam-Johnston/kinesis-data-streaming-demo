data "aws_caller_identity" "current" {}

resource "random_password" "password" {
  length           = 16
  special          = true
}

resource "aws_elasticsearch_domain" "this" {
  domain_name = var.domain_name
  elasticsearch_version = "6.7"
  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  cluster_config {
    instance_type = "t3.small.elasticsearch"
  }

  advanced_security_options {

    enabled = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name      = local.master_user_name
      master_user_password  = random_password.password.result
    }
  }

  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}
