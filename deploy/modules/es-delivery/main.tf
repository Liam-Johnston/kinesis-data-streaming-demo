resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.owner}-es-error-log-bucket"
  force_destroy = true

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_kinesis_firehose_delivery_stream" "es_delivery" {
  name        = "${var.owner}-log-delivery-stream"
  destination = "elasticsearch"


  elasticsearch_configuration {
    domain_arn         = var.domain_arn
    role_arn           = var.role_arn
    index_name         = "analysed-logs"
    buffering_interval = 60
    buffering_size     = 1
  }

  s3_configuration {
    role_arn   = aws_iam_role.s3_delivery_role.arn
    bucket_arn = aws_s3_bucket.log_bucket.arn
  }
}
