# ------------------------------------------------------------------------
# Amazon VPC variables
# ------------------------------------------------------------------------

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "vpc_endpoints" {
  type        = map(any)
  description = "Services to access from VPC Endpoint"
}