# ------------------------------------------------------------------------
# Amazon API GW variables
# ------------------------------------------------------------------------

variable "aws_region_name" {
  type        = string
  description = "The current AWS Region name"
}

variable "account_id" {
  type        = string
  description = "The current Accound ID"
}

variable "template_file" {
  type        = string
  description = "The OpenAPI file"
}

variable "template_file_vars" {
  type        = map(string)
  description = "The OpenAPI file vars"
}

variable "name" {
  type        = string
  description = "API GW Name"
}

variable "description" {
  type        = string
  description = "API GW description"
}