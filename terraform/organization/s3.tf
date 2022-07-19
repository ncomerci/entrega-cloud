# ---------------------------------------------------------------------------
# Amazon S3 
# ---------------------------------------------------------------------------

module "s3" {
  for_each = local.s3
  source   = "../modules/s3_4.0"

  providers = {
    aws = aws.aws
  }

  bucket_name    = each.value.bucket_name
  bucket_acl     = try(each.value.bucket_acl, "private")
  is_website     = try(each.value.is_website, false)
  is_log         = try(each.value.is_log, false)
  logs_from      = try(each.value.logs_from, "")
  objects        = try(each.value.objects, [])
  website_name   = local.bucket_name
  mime_types     = local.mime_types
  website_config = try(each.value.website_config, {})
  template_file  = try(data.template_file.userdata.rendered, {})
  encrypt        = try(each.value.encrypt, false)
}