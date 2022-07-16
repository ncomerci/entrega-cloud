# ---------------------------------------------------------------------------
# Amazon Cognito
# ---------------------------------------------------------------------------

module "cognito" {

  source = "../modules/cognito"

  redirect_uri    = local.bucket_name
  aws_region_name = data.aws_region.current.name
  user_pool_name  = local.cognito.pool_name
  domain_name     = local.cognito.domain_name
  client_name     = local.cognito.client_name

  providers = {
    aws = aws.aws
  }
}