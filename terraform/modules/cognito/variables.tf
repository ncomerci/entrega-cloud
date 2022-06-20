# ---------------------------------------------------------------------------
# Amazon Cognito variables
# ---------------------------------------------------------------------------

variable "redirect_uri" {
  type = string
  description = "website endpoint to redirect"
}

variable "aws_region_name" {
  type = string
  description = "region name"
}