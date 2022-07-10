# ---------------------------------------------------------------------------
# Amazon DynamoDB variables
# ---------------------------------------------------------------------------

variable "read_capacity" {
  type    = number
  default = 30
}

variable "write_capacity" {
  type    = number
  default = 30
}