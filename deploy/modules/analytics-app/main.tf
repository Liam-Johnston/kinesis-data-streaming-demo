resource "aws_kinesis_analytics_application" "app" {
  name = "${var.owner}-log-analytics-app"
  code = data.template_file.app.rendered


  inputs {
    name_prefix = local.source_sql_stream_prefix

    kinesis_firehose {
      resource_arn = var.input_firehose_arn
      role_arn     = aws_iam_role.app_input_role.arn
    }

    schema {
      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }
      }
      record_columns {
        mapping  = "$.host"
        name     = "host"
        sql_type = "VARCHAR(16)"
      }
      record_columns {
        mapping  = "$.datetime"
        name     = "datetime"
        sql_type = "VARCHAR(32)"
      }
      record_columns {
        mapping  = "$.request"
        name     = "request"
        sql_type = "VARCHAR(64)"
      }
      record_columns {
        mapping  = "$.response"
        name     = "response"
        sql_type = "INTEGER"
      }
      record_columns {
        mapping  = "$.bytes"
        name     = "bytes"
        sql_type = "INTEGER"
      }
    }

    starting_position_configuration {
      starting_position = "NOW"
    }
  }

  outputs {
    name = local.destination_sql_stream

    schema {
      record_format_type = "JSON"
    }

    kinesis_firehose {
      resource_arn = var.output_firehose_arn
      role_arn     = aws_iam_role.app_output_role.arn
    }
  }

  start_application = true
}
