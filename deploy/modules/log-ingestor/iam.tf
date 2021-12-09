resource "aws_iam_role" "firehose_role" {
  name = "firehose-role"
  path = "/${var.owner}/"

  assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "firehose.amazonaws.com"
          }
        }
      ]
    })
}

data "aws_iam_policy_document" "s3_log_delivery" {
  statement {
      sid     = "AllowS3Delivery"
      actions = [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ]
      resources = [
        aws_s3_bucket.log_bucket.arn,
        "${aws_s3_bucket.log_bucket.arn}/*"
      ]
  }
}

resource "aws_iam_policy" "s3_log_delivery" {
  name = "s3-log-delivery"
  path = "/${var.owner}/"
  policy  = data.aws_iam_policy_document.s3_log_delivery.json
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.firehose_role.name
  policy_arn = aws_iam_policy.s3_log_delivery.arn
}
