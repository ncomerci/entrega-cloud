# ---------------------------------------------------------------------------
# Amazon DynamoDB
# ---------------------------------------------------------------------------

resource "aws_dynamodb_table" "users" {
  name           = local.table.users.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = local.table.users.key
    type = "S"
  }

  hash_key = local.table.users.key

  tags = {
    name       = "Users Table MHS"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }
}

resource "aws_dynamodb_table" "appointments" {
  name           = local.table.appointments.name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = local.table.appointments.key
    type = "S"
  }

  hash_key = local.table.appointments.key

  tags = {
    name       = "Appointments Table MHS"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }
}