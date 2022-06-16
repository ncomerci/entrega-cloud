variable "table_name" {
  type = string
  default = "mhs-db"
  description = "DB table name"
}

variable "read_capacity" {
  type = number
  default = 30
}

variable "write_capacity" {
  type = number
  default = 30
}

variable "table_key" {
  type = string
  default = "testId"
}