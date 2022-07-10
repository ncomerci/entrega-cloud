# ---------------------------------------------------------------------------
# Amazon Cognito
# ---------------------------------------------------------------------------

module "cognito" {

  source = "../modules/cognito"

  redirect_uri    = local.bucket_name
  aws_region_name = data.aws_region.current.name

  providers = {
    aws = aws.aws
  }
}