# ---------------------------------------------------------------------------
# Amazon S3 
# ---------------------------------------------------------------------------

module "s3" {

  source = "../modules/s3_4.0"

  providers = {
    aws = aws.aws
  }

  bucket_name = local.bucket_name
  mime_types  = local.mime_types
}

resource "aws_s3_object" "this" {

  provider      = aws.aws

  bucket        = module.s3.id
  key           = "index.html"
  content       = data.template_file.userdata.rendered
  content_type  = "text/html"
  storage_class = "STANDARD"
}
