# ---------------------------------------------------------------------------
# Amazon Cognito variables
# ---------------------------------------------------------------------------

variable "redirect_uri" {
  type        = string
  description = "website endpoint to redirect"
}

variable "aws_region_name" {
  type        = string
  description = "region name"
}

variable "user_pool_name" {
  type        = string
  description = "User pool name"
}

variable "client_name" {
  type        = string
  description = "Client name"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}