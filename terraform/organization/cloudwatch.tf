# ---------------------------------------------------------------------------
# Amazon Cloudwatch
# ---------------------------------------------------------------------------

module "cloudwatch" {
    source = "../modules/cloudwatch"  
    providers = {
        aws = aws.aws
    }
}