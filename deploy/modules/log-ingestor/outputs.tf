output "firehose_stream" {
  value = aws_kinesis_firehose_delivery_stream.log_stream_to_s3.name
}
