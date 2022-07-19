# ------------------------------------------------------------------------
# Amazon S3 variables
# ------------------------------------------------------------------------

variable "bucket_name" {
  type        = string
  description = "The name of the bucket. Must be less than or equal to 63 characters in length."
}

variable "block_public_access" {
  type        = bool
  default     = true
  description = "Determines the S3 account-level Public Access Block configuration. For more information about these settings, see the AWS S3 documentation: https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html"
}

variable "bucket_acl" {
  type        = string
  default     = "private"
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. For more information about these settings, see the AWS S3 documentation: https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl"
}

variable "mime_types" {
  type        = map(any)
  description = "Mime types"
}

variable "is_website" {
  type        = bool
  description = "If the bucket is a website bucket then contains = true, else false "
  default     = false
}

variable "is_log" {
  type        = bool
  description = "If the bucket is a logging bucket"
  default     = false
}

variable "logs_from" {
  type        = string
  description = "Name of the bucket to log from"
  default     = ""
}

variable "objects" {
  type        = list(any)
  description = "Bucket objects"
  default     = []
}

variable "website_name" {
  type        = string
  description = "website name"
}

variable "website_config" {
  type        = map(any)
  description = "Website configuration"
  default     = {}
}

variable "template_file" {
  type        = any
  description = "index.html"
  default     = {}
}

variable "encrypt" {
  type        = bool
  description = "Encrypted bucket with AWS managed key"
  default     = false
}