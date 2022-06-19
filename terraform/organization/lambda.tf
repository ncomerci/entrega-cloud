# ---------------------------------------------------------------------------
# AWS Lambda resources
# ---------------------------------------------------------------------------

# Lambda

module "lambda" {
  for_each = local.lambdas
  providers = {
    aws = aws.aws
  }

  source                  = "../modules/lambda"
  local_path              = local.path
  lambda_info             = each.value
  account_id              = data.aws_caller_identity.current.account_id
  apigw_execution_arn     = module.apigw.execution_arn
}
