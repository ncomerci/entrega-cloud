module "cloudfront" { 
    source = "../modules/cloudfront"
    domain_name = module.s3.website_endpoint
    api_domain_name = module.apigw.domain_name
    depends_on = [
      module.s3
    ]
}