variable "domain_name" {
  type = string
}

variable "api_domain_name" {
  type = string
}

variable "web_acl_arn" {
  type = string
  description = "WAF Web ACL ARN"
}