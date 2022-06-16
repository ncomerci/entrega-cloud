module "cloudfront" { 
    source = "../modules/cloudfront"
    domain_name = module.s3["www-website"].website_endpoint
}