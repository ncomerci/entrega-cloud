# ------------------------------------------------------------------------------
# Amazon Lambda
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "this" {
  # provider = aws.aws
  filename      = "${var.local_path}/lambda/lambda_list_medical_records.zip"
  function_name = "AWSLambdaHandler-listMedicalRecords"
  role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  handler       = "lambda_list_medical_records.main"
  runtime       = "python3.9"
}

resource "aws_lambda_permission" "this" {
  # provider = aws.aws

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn    = var.api_gw_source_arn
}
