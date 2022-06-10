# 1 - S3 bucket
resource "aws_s3_bucket" "montegrande_website" {
    bucket              = var.montegrande_website_bucket_name
    object_lock_enabled = false
}