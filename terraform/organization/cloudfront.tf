module "cloudfront" { 
    source = "../modules/cloudfront"
    domain_name = module.s3["website"].website_endpoint
}