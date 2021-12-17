data "template_file" "app" {
  template = file("${path.module}/src/app.sql")

  vars = {
    DESTINATION_SQL_STREAM   = local.destination_sql_stream
    SOURCE_SQL_STREAM_PREFIX = local.source_sql_stream_prefix
  }
}
