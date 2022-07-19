# ------------------------------------------------------------------------------
# Amazon S3
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "this" {
  bucket              = var.bucket_name
  object_lock_enabled = false
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = length(var.website_config) != 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "index_document" {
    for_each = try(var.website_config.index_document, {})
    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try(var.website_config.error_document, {})
    content {
      key = error_document.value
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = try(var.website_config.redirect, {})
    content {
      protocol  = "http"
      host_name = var.website_name
    }
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

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.encrypt == true ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# Upload objects 

resource "aws_s3_object" "this" {
  count        = try(length(var.objects), 0)
  bucket       = aws_s3_bucket.this.id
  key          = var.objects[count.index].key
  source       = try(var.objects[count.index].source, "")
  etag         = try(var.objects[count.index].etag, "")
  content_type = try(var.objects[count.index].content_type, "")
}

## NOTA: Este recurso está repetido
#La idea era concantenar este objeto (index.html) a lista de var.objects del objeto s3.website que está en locals.tf. 
#El problema es que se genera dinamicamente con un for para recorrer todo la carpeta de front. 
#Como es dinamico, la variable count no sabe cuántos elementos tiene y no lo puede generar. 
#Tratamos cambiar el count por un foreach pero no se puede hacer con lists, sí con objects. 
#Pero nosotros teníamos lists porque sino no se podía hacer el for dinámico con todo el front. 
resource "aws_s3_object" "frontend" {

  bucket        = var.website_name
  key           = "index.html"
  content       = var.template_file
  content_type  = "text/html"
  storage_class = "STANDARD"
}