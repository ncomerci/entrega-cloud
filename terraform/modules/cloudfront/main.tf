# ---------------------------------------------------------------------------
# Amazon Cloudfront
# ---------------------------------------------------------------------------

resource "aws_cloudfront_distribution" "s3" {
  origin {
    #domain_name = "www.mhs.com.s3-website-us-east-1.amazonaws.com" 
    #domain_name = module.s3["www-website"].website_endpoint
    #domain_name = module.s3["website"].bucket_regional_domain_name
    domain_name = var.domain_name
    origin_id   = local.s3_origin_id

    #s3_origin_config {
    #  origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    #}

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    #domain_name = replace(aws_api_gateway_deployment.deployment.invoke_url, "/^https?://([^/]*).*/", "$1")
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

  enabled = true
  #is_ipv6_enabled     = true
  #comment             = "Some comment"
  default_root_object = "index.html"

  #logging_config {
  #  include_cookies = false
  #  bucket          = "mhs-logs-itba-cp-g1"
  #  prefix          = "myprefix"
  #}

  #aliases = ["mhs.com"]

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

  # Cache behavior with precedence 0
  #ordered_cache_behavior {
  #  path_pattern     = "/content/immutable/*"
  #  allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #  cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #  target_origin_id = local.s3_origin_id
  #
  #  forwarded_values {
  #    query_string = false
  #    headers      = ["Origin"]
  #
  #    cookies {
  #      forward = "none"
  #    }
  #  }
  #
  #  min_ttl                = 0
  #  default_ttl            = 86400
  #  max_ttl                = 31536000
  #  compress               = true
  #  viewer_protocol_policy = "redirect-to-https"
  #}

  # Cache behavior with precedence 1
  #ordered_cache_behavior {
  #  path_pattern     = "/content/*"
  #  allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #  cached_methods   = ["GET", "HEAD"]
  #  target_origin_id = local.s3_origin_id
  #
  #  forwarded_values {
  #    query_string = false
  #
  #    cookies {
  #      forward = "none"
  #    }
  #  }
  #
  #  min_ttl                = 0
  #  default_ttl            = 3600
  #  max_ttl                = 86400
  #  compress               = true
  #  viewer_protocol_policy = "redirect-to-https"
  #}

  #price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
