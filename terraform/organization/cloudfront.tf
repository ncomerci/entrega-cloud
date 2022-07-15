# ---------------------------------------------------------------------------
# Amazon CloudFront
# ---------------------------------------------------------------------------

module "cloudfront" {

  source          = "../modules/cloudfront"

  providers = {
    aws = aws.aws
  }

  domain_name     = module.s3.website_endpoint
  api_domain_name = module.apigw.domain_name
  web_acl_arn     = module.waf.web_acl_arn

}