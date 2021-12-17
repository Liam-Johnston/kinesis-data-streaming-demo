resource "aws_iam_role" "app_input_role" {
  name = "${var.owner}-analytics-firehose-input"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "app_input" {
  statement {
    sid = "ReadInputFirehose"
    actions = [
      "firehose:DescribeDeliveryStream",
      "firehose:GetShardIterator",
      "firehose:GetRecords"
    ]
    resources = [
      var.input_firehose_arn
    ]
  }
}

resource "aws_iam_policy" "app_input" {
  name   = "${var.owner}-analytics-firehose-input"
  policy = data.aws_iam_policy_document.app_input.json
}

resource "aws_iam_role_policy_attachment" "app_input" {
  role       = aws_iam_role.app_input_role.name
  policy_arn = aws_iam_policy.app_input.arn
}


resource "aws_iam_role" "app_output_role" {
  name = "${var.owner}-analytics-firehose-output"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "kinesisanalytics.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "app_output" {
  statement {
    sid = "WriteOutputFirehose"
    actions = [
      "firehose:DescribeDeliveryStream",
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [
      var.output_firehose_arn
    ]
  }
}

resource "aws_iam_policy" "app_output" {
  name   = "${var.owner}-analytics-firehose-output"
  policy = data.aws_iam_policy_document.app_output.json
}

resource "aws_iam_role_policy_attachment" "app_output" {
  role       = aws_iam_role.app_output_role.name
  policy_arn = aws_iam_policy.app_output.arn
}
