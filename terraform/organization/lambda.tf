# ---------------------------------------------------------------------------
# AWS Lambda resources
# ---------------------------------------------------------------------------

# TODO hacer foreach
# Lambda

module "lambda" {
  providers = {
    aws = aws.aws
  }
  source                  = "../modules/lambda"
  api_gw_source_arn       = module.apigw.source_arn
  local_path              = local.path
  account_id              = data.aws_caller_identity.current.account_id
}

# resource "aws_lambda_permission" "apigw_get_medical_record" {
#  provider = aws.aws

#  statement_id  = "AllowExecutionFromAPIGateway"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.this.function_name
#  principal     = "apigateway.amazonaws.com"

#  source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
# }


# resource "aws_lambda_function" "this" {
#  provider = aws.aws

#  filename      = "${local.path}/lambda/lambda_get_medical_record.zip"
#  function_name = "AWSLambdaHandler-getMedicalRecord"
#  role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
#  handler       = "lambda_handler.main"
#  runtime       = "python3.9"
# }

# resource "aws_lambda_permission" "apigw_lambda2" {
#   provider = aws.aws

#   statement_id  = "AllowExecutionFromAPIGateway"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.list_medical_records.function_name
#   principal     = "apigateway.amazonaws.com"

#   source_arn = "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
# }

# resource "aws_lambda_function" "list_medical_records" {
#   provider = aws.aws

#   filename      = "${local.path}/lambda/lambda_list_medical_records.zip"
#   function_name = "AWSLambdaHandler-listMedicalRecords"
#   role          = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
#   handler       = "lambda_handler.main"
#   runtime       = "python3.9"
# }