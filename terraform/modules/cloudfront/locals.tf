# ---------------------------------------------------------------------------
# Amazon Cloudfront locals
# ---------------------------------------------------------------------------

locals {

  s3_origin_id = "S3"

  api_origin_id = "apigw"

  tags = {
    name = "Cloudfront Distribution MHS"
  }
}