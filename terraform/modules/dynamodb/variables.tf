#variable "user_table_name" {
#  type = string
#  default = "user-db"
#  description = "DB Users"
#}

variable "read_capacity" {
  type = number
  default = 30
}

variable "write_capacity" {
  type = number
  default = 30
}

#variable "table_key" {
#  type = string
#  default = "testId"
#}