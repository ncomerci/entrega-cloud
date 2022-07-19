# ---------------------------------------------------------------------------
# Amazon VPC
# ---------------------------------------------------------------------------

module "vpc" {
  source = "../modules/vpc"

  providers = {
    aws = aws.aws
  }
  vpc_cidr      = local.vpc_cidr
  vpc_endpoints = local.vpc_endpoints
}