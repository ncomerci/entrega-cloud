# ---------------------------------------------------------------------------
# Amazon Cloudfront variables
# ---------------------------------------------------------------------------

variable "domain_name" {
  type = string
  description = "Domain name"
}

variable "api_domain_name" {
  type = string
  description = "API domain name"
}

variable "web_acl_arn" {
  type        = string
  description = "WAF Web ACL ARN"
}