data "template_file" "user_data" {
  template = file("${path.module}/src/user-data.sh")

  vars = {
    REGION          = var.region
    DELIVERY_STREAM = var.firehose_stream
  }
}
