# ---------------------------------------------------------------------------
# Amazon Cloudwatch
# ---------------------------------------------------------------------------

module "cloudwatch" {
    source = "../modules/cloudwatch"  
    service_to_monitor = module.apigw.name
    providers = {
        aws = aws.aws
    }
}