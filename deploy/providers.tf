provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project = local.project_name
      Owner   = var.owner
    }
  }
}

provider "random" {
}
