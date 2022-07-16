# ---------------------------------------------------------------------------
# Amazon DynamoDB
# ---------------------------------------------------------------------------

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = var.table_hash_key
    type = "S"
  }

  hash_key = var.table_hash_key

}