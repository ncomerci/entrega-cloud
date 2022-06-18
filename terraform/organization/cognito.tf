# ---------------------------------------------------------------------------
# Amazon Cognito
# ---------------------------------------------------------------------------

module "cognito" {
    source = "../modules/cognito"
    pool_name = "mhs-user-pool"
    domain_name = "montegrande-health-system"
    client_name = "mhs-client"
    redirect_uri = local.bucket_name
    providers = {
        aws = aws.aws
    }
}