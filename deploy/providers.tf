provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project = var.project_name
      Owner   = var.owner
    }
  }
}

provider "random" {
}