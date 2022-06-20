# ------------------------------------------------------------------------------
# Amazon Lambda
# ------------------------------------------------------------------------------

resource "aws_lambda_function" "this" {

  filename      = var.lambda_info.filename
  function_name = var.lambda_info.function_name
  role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  handler       = var.lambda_info.handler
  runtime       = "python3.9"

  # TODO(para el final): Lambdas en VPC, accederian a S3 y DynamoDB por VPC endpoint 
  #vpc_config {
  #  subnet_ids          = var.subnet_ids
  #  security_group_ids  = var.sg_ids
  #}

  tags = {
    name       = "Lambda ${var.lambda_info.function_name}"
    author     = "MHS Grupo 1"
    version    = 1
    university = "ITBA"
    subject    = "Cloud Computing"
  }
}

resource "aws_lambda_permission" "this" {
  # provider = aws.aws

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.apigw_execution_arn}/*/${var.lambda_info.method}${var.lambda_info.path}"
}
