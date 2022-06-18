# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

module "apigw" { 
  source = "../modules/apigw-2"

  providers = {
    aws = aws.aws
  }

  invoke_arn = module.lambda.invoke_arn
  aws_region_name = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}