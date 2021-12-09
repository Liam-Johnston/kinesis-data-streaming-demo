module "server" {
  source          = "./modules/server"
  owner           = var.owner
  region          = var.region
  firehose_stream = module.log_ingestor.firehose_stream
  ip_address      = var.ip_address
}

module "log_ingestor" {
  source = "./modules/log-ingestor"
  owner  = var.owner
}

module "open_search" {
  source       = "./modules/open-search"
  owner        = var.owner
  ip_address   = var.ip_address
  region       = var.region
  project_name = var.project_name
  domain_name  = local.es_domain
}
