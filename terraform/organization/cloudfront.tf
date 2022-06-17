module "cloudfront" { 
    source = "../modules/cloudfront"
    domain_name = module.s3.website_endpoint
    depends_on = [
      module.s3
    ]
}