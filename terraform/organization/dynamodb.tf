module "DynamoDB" {
  source = "../modules/dynamodb"
  providers = {
    aws = aws.aws
  }
}
