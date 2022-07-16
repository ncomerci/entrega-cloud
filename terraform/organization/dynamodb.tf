# ---------------------------------------------------------------------------
# Amazon DynamoDB
# ---------------------------------------------------------------------------

module "DynamoDB" {
  for_each = local.dynamodb
  source   = "../modules/dynamodb"

  providers = {
    aws = aws.aws
  }

  table_name     = each.value.name
  table_hash_key = each.value.hash_key
}
