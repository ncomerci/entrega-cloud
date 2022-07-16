# ------------------------------------------------------------------------------
# Amazon S3
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  object_lock_enabled = false
}

resource "aws_s3_bucket_website_configuration" "website" {
  count  = var.is_website == true && length(split("www", var.bucket_name)) == 1 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_website_configuration" "www" {
  count  = var.is_website == true && length(split("www", var.bucket_name)) > 1 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  redirect_all_requests_to {
    protocol  = "http"
    host_name = var.website_name
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.is_website == true ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_s3_bucket_acl" "this" {
  count  = var.is_log == true ? 1 : 0
  bucket = aws_s3_bucket.this.id
  acl    = var.bucket_acl
}

resource "aws_s3_bucket_logging" "this" {
  count  = var.is_log == true ? 1 : 0
  bucket = var.logs_from // webiste

  target_bucket = aws_s3_bucket.this.id // logs
  target_prefix = "log/"
}

# Upload objects 

resource "aws_s3_object" "this" {
  count = try(length(var.objects), [])

  bucket = aws_s3_bucket.this.id
  key    = var.objects[count.index].key
  source = var.objects[count.index].source
  etag   = var.objects[count.index].etag
  content_type   = try(var.objects[count.index].content_type, "")
} 