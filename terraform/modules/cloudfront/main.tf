# ---------------------------------------------------------------------------
# Amazon Cloudfront
# ---------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "s3" {
  origin {
    
    domain_name = var.domain_name
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    
    domain_name = var.api_domain_name
    origin_id   = "apigw"
    origin_path = "/production"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
 
  web_acl_id = var.web_acl_arn

  enabled = true
 
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    environment = "production"
    name        = "Cloudfront Distribution MHS"
    author      = "MHS Grupo 1"
    version     = 1
    university  = "ITBA"
    subject     = "Cloud Computing"  
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
