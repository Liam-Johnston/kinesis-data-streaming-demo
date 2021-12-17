resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${var.owner}-log-bucket"
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

resource "aws_kinesis_firehose_delivery_stream" "log_stream_to_s3" {
  name        = "${var.owner}-web-log-ingestion-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn        = aws_iam_role.firehose_role.arn
    bucket_arn      = aws_s3_bucket.log_bucket.arn
    buffer_interval = 60
    buffer_size     = 1
  }
}
