data "aws_iam_policy" "amazon_kinesis_firehose_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"
}

resource "aws_iam_role" "server_role" {
  name = "${var.owner}-server-logging-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_role_policy_attachment" {
  role       = aws_iam_role.server_role.name
  policy_arn = data.aws_iam_policy.amazon_kinesis_firehose_full_access.arn
}

resource "aws_iam_instance_profile" "server_profile" {
  name = "${var.owner}-server-profile"
  role = aws_iam_role.server_role.name
}
