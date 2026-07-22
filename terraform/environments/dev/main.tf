provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source      = "../../modules/vpc"
  environment = "dev"
}

module "eks" {
  source             = "../../modules/eks"
  environment        = "dev"
  private_subnet_ids = module.vpc.private_subnets_ids
}