resource "aws_iam_role" "s3_delivery_role" {
  name = "${var.owner}-s3-error-log-delivery-role"

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

data "aws_iam_policy_document" "s3_delivery" {
  statement {
    sid = "AllowS3Delivery"
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

resource "aws_iam_policy" "s3_delivery" {
  name   = "${var.owner}-s3-error-log-delivery"
  policy = data.aws_iam_policy_document.s3_delivery.json
}


resource "aws_iam_role_policy_attachment" "attach-s3-delivery" {
  role       = aws_iam_role.s3_delivery_role.name
  policy_arn = aws_iam_policy.s3_delivery.arn
}
