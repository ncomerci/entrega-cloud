# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

module "apigw" {
  source = "../modules/apigw"

  providers = {
    aws = aws.aws
  }
  name            = local.apigateway.name
  description     = local.apigateway.description
  aws_region_name = data.aws_region.current.name
  account_id      = data.aws_caller_identity.current.account_id

  template_file = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "Example"
      version = "1.0"
    }
    paths = {
      "/medical-records" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "aws_proxy"
            uri                  = module.lambda["list-medical-records"].invoke_arn
          }
        }
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "aws_proxy"
            uri                  = module.lambda["new-medical-record"].invoke_arn
          }
        }
      }
      "/appointments" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "aws_proxy"
            uri                  = module.lambda["get-appointment"].invoke_arn
          }
        }
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "aws_proxy"
            uri                  = module.lambda["post-appointment"].invoke_arn
          }
        }
      }

    }
  })
  template_file_vars = {
    lambda_get_medical_records = module.lambda["list-medical-records"].invoke_arn
  }
}