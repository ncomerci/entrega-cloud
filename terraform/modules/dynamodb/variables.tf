# ---------------------------------------------------------------------------
# Amazon DynamoDB variables
# ---------------------------------------------------------------------------

variable "table_name" {
  type        = string
  description = "The name of the table"
}

variable "table_hash_key" {
  type        = string
  description = "The hash key of the table"
}

variable "read_capacity" {
  type        = number
  default     = 30
  description = "Read Capacity"
}

variable "write_capacity" {
  type        = number
  default     = 30
  description = "Write Capacity"
}

