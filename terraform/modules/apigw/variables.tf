# ------------------------------------------------------------------------
# Amazon APIGW variables
# ------------------------------------------------------------------------

variable "invoke_arn" {
  type        = string
  description = "The function's invoke ARN"
}

variable "aws_region_name" {
  type = string
  description = "The current AWS Region name"
}

variable "account_id" {
  type = string
  description = "The current Accound ID"
}
