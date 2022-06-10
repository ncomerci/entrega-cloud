# ---------------------------------------------------------------------------
# Amazon S3 resources
# ---------------------------------------------------------------------------

# 1 - S3 bucket
resource "aws_s3_bucket" "montegrande_website" {
    bucket              = "montegrande-bucket"#var.montegrande_website_bucket_name
    object_lock_enabled = false
}

#module "s3" {
#  for_each = local.s3
#  source   = "../modules/s3_4.0"
#
#  providers = {
#    aws = aws.aws
#  }
#
#  #bucket_name = each.value.bucket_name
#  #objects     = try(each.value.objects, {})
#}
#
#resource "aws_s3_object" "montegrande" {
#  provider = aws.aws
#
#  bucket        = module.s3["montegrande_website"].id
#  key           = "index.html"
#  content       = data.template_file.userdata.rendered
#  content_type  = "text/html"
#  storage_class = "STANDARD"
#}