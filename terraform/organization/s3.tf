# ---------------------------------------------------------------------------
# Amazon S3 
# ---------------------------------------------------------------------------

module "s3" {
  for_each = local.s3
  source = "../modules/s3_4.0"

  providers = {
    aws = aws.aws
  }

  bucket_name = each.value.bucket_name
  bucket_acl  = try(each.value.bucket_acl, "private")
  is_website  = try(each.value.is_website, false)
  is_log      = try(each.value.is_log, false)
  logs_from   = try(each.value.logs_from, "")
  objects     = try(each.value.objects, {})
  website_name = local.bucket_name
  mime_types  = local.mime_types
}

resource "aws_s3_object" "this" {

  provider      = aws.aws

  bucket        = module.s3["website"].id
  key           = "index.html"
  content       = data.template_file.userdata.rendered
  content_type  = "text/html"
  storage_class = "STANDARD"
}

# Upload frontend assets 
resource "aws_s3_object" "frontend" {
  #count = var.is_website == true && length(split("www", var.bucket_name)) == 1 ? 1 : 0
  provider      = aws.aws

  for_each = fileset("../resources/html", "**/*.*")

  bucket = local.bucket_name
  key    = each.value

  source = "../resources/html/${each.value}"

  etag         = filemd5("../resources/html/${each.value}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}

#resource "aws_s3_object" "endpoints" {
#
#  provider      = aws.aws
#
#  bucket        = module.s3["website"].id
#  key           = "assets/js/endpoints.js"
#  content       = data.template_file.userdata.rendered
#  etag          = md5(data.template_file.userdata.rendered)
#  content_type  = "text/javascript"
#  storage_class = "STANDARD"
#}