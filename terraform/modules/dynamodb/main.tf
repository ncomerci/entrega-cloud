# ---------------------------------------------------------------------------
# Amazon DynamoDB
# ---------------------------------------------------------------------------

resource "aws_dynamodb_table" "users" {
  name = local.table.users.name
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = local.table.users.key
    type = "S"
  }

  hash_key = local.table.users.key
}

resource "aws_dynamodb_table" "appointments" {
  name = local.table.appointments.name
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = local.table.appointments.key
    type = "S"
  }

  hash_key = local.table.appointments.key
}