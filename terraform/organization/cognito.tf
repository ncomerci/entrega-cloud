# ---------------------------------------------------------------------------
# Amazon Cognito
# ---------------------------------------------------------------------------

module "cognito" {
    source = "../modules/cognito"
    pool_name = "pool_mhs"
    domain_name = "mhs-g1"
    client_name = "mhs-client"
    providers = {
        aws = aws.aws
    }
}