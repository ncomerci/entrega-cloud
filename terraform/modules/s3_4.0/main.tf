# ------------------------------------------------------------------------------
# Amazon S3
# ------------------------------------------------------------------------------

# 1 - Static Website Bucket
resource "aws_s3_bucket" "website" {
  bucket              = var.bucket_name
  object_lock_enabled = false

  tags = {
    name       = "S3 Bucket ${var.bucket_name}"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }


}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "website" {

  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.website.json
}

resource "aws_s3_bucket_acl" "website" {
  bucket = aws_s3_bucket.website.id
  acl    = var.bucket_acl
}

# www redirecto to mhs.com
resource "aws_s3_bucket" "www" {
  bucket              = "www.${var.bucket_name}"
  object_lock_enabled = false
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id
  redirect_all_requests_to {
    protocol  = "http"
    host_name = aws_s3_bucket.website.id
  }
}
resource "aws_s3_bucket_policy" "www" {

  bucket = aws_s3_bucket.www.id
  policy = data.aws_iam_policy_document.www.json
}

resource "aws_s3_bucket_acl" "www" {
  bucket = aws_s3_bucket.www.id
  acl    = var.bucket_acl
}

# Upload frontend assets 
resource "aws_s3_object" "this" {
  for_each = fileset("../resources/html", "**/*.*")

  bucket = aws_s3_bucket.website.id
  key    = each.value

  source = "../resources/html/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag         = filemd5("../resources/html/${each.value}")
  content_type = lookup(var.mime_types, regex("\\.[^.]+$", each.value), null)
}

# Log bucket

resource "aws_s3_bucket" "logs" {
  bucket = "mhs-logs-itba-cp-g1"

  tags = {
    name       = "S3 Bucket Logs"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }

}

resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.website.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "log/"
}


# Medical Records 

resource "aws_s3_bucket" "medical_records" {
  bucket = "mhs-medical-records-itba-cp-g1"

  tags = {
    name       = "S3 Bucket Medical Records"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }

}

# Mock data
resource "aws_s3_object" "medical_record_radiografia" {
  key    = "user1/radiografia-mano.jpg"
  bucket = aws_s3_bucket.medical_records.id
  source = "../resources/images/radiografia-mano.jpg"
}

resource "aws_s3_object" "medical_record_pdf" {
  key    = "user1/medical-record.pdf"
  bucket = aws_s3_bucket.medical_records.id
  source = "../resources/docs/medical_record.pdf"
}