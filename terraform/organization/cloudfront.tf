# ---------------------------------------------------------------------------
# Amazon CloudFront
# ---------------------------------------------------------------------------

module "cloudfront" {

  source = "../modules/cloudfront"

  providers = {
    aws = aws.aws
  }

  domain_name     = module.s3["www-website"].website_endpoint
  api_domain_name = module.apigw.domain_name
  web_acl_arn     = module.waf.web_acl_arn
  apigw_origin_id = "api-gw"
  s3_origin_id    = "S3"
}