# ------------------------------------------------------------------------------
# Amazon S3
# ------------------------------------------------------------------------------

# 1 - S3 bucket
resource "aws_s3_bucket" "this" {
    bucket              = var.bucket_name
    object_lock_enabled = false
}

# 2 -Bucket policy
resource "aws_s3_bucket_policy" "this" {
    count = var.objects != {} ? 1 : 0

    bucket = aws_s3_bucket.this.id
    policy = data.aws_iam_policy_document.this.json
}

# 3 -Website configuration
resource "aws_s3_bucket_website_configuration" "this" {
    bucket = aws_s3_bucket.this.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

# 4 - Access Control List
resource "aws_s3_bucket_acl" "this" {
    bucket = aws_s3_bucket.this.id
    acl    = var.bucket_acl
}

# 5 - Upload objects TODO ABAJO SE CARGA TODA LA CARPETA
#resource "aws_s3_object" "this" {
#    for_each =  try(var.objects, {}) #{ for object, key in var.objects: object => key if try(var.objects, {}) != {} }
#
#    bucket        = aws_s3_bucket.this.id
#    key           = try(each.value.rendered, replace(each.value.filename, "html/", "")) # remote path
#    source        = try(each.value.rendered, format("../resources/%s", each.value.filename)) # where is the file located
#    content_type  = each.value.content_type
#    storage_class = try(each.value.tier, "STANDARD")
#}

# 6 - Log bucket

resource "aws_s3_bucket" "log_bucket" {
  bucket = "mhs-logs-itba-cp-g1"
}

resource "aws_s3_bucket_acl" "log_bucket_acl" {
  bucket = aws_s3_bucket.log_bucket.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}


# 7 - Medical Records 

resource "aws_s3_bucket" "medical_records" {
  bucket = "mhs-medical-records-itba-cp-g1"
}

# TODO foreach
resource "aws_s3_bucket_object" "medical_record_radiografia" {
    key    = "user1/radiografia-mano.jpg"
    bucket = aws_s3_bucket.medical_records.id
    source = "../resources/images/radiografia-mano.jpg"
}

resource "aws_s3_bucket_object" "medical_record_pdf" {
    key    = "user1/medical-record.pdf"
    bucket = aws_s3_bucket.medical_records.id
    source = "../resources/docs/medical_record.pdf"
}

# TODO PATH RELATIVO
resource "aws_s3_object" "this" {
  for_each = fileset("/home/eugenia/cloud/cloud-computing/terraform/resources/html", "**/*.*")

  bucket = aws_s3_bucket.this.id
  key    = each.value
  source = "/home/eugenia/cloud/cloud-computing/terraform/resources/html/${each.value}"
  # etag makes the file update when it changes; see https://stackoverflow.com/questions/56107258/terraform-upload-file-to-s3-on-every-apply
  etag   = filemd5("/home/eugenia/cloud/cloud-computing/terraform/resources/html/${each.value}")
}