resource "aws_secretsmanager_secret" "es_credentials" {
  name = "${var.owner}/${var.project_name}/es_credentials"
}

resource "aws_secretsmanager_secret_version" "es_credentials" {
  secret_id     = aws_secretsmanager_secret.es_credentials.id
  secret_string = jsonencode({
    master_user_name = local.master_user_name
    master_password  = random_password.password.result
  })
}
