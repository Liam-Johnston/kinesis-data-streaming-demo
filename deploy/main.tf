module "log_ingestor" {
  source = "./modules/log-ingestor"

  owner = var.owner
}

module "server" {
  source = "./modules/server"

  owner           = var.owner
  region          = var.region
  firehose_stream = module.log_ingestor.firehose_stream
}

module "elastic_search_cluser" {
  source = "./modules/elastic-search-cluster"

  owner                       = var.owner
  region                      = var.region
  project_name                = local.project_name
  domain_name                 = "${local.user_initials}-log-summary"
  delivery_firehose_role_arn  = aws_iam_role.es_delivery_role.arn
  delivery_firehose_role_name = aws_iam_role.es_delivery_role.name
}

module "es_delivery" {
  source = "./modules/es-delivery"

  owner      = var.owner
  domain_arn = module.elastic_search_cluser.domain_arn
  region     = var.region
  role_arn   = aws_iam_role.es_delivery_role.arn
}

module "analytics_app" {
  source = "./modules/analytics-app"

  owner               = var.owner
  output_firehose_arn = module.es_delivery.stream_arn
  input_firehose_arn  = module.log_ingestor.stream_arn
}
