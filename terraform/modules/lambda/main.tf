# ------------------------------------------------------------------------------
# Amazon Lambda
# ------------------------------------------------------------------------------

module "global_settings" {
  source = "../global"
}

resource "aws_lambda_function" "this" {

  filename      = var.lambda_info.filename
  function_name = var.lambda_info.function_name
  role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  handler       = var.lambda_info.handler
  runtime       = "python3.9"

  tags = {
    name = "Lambda ${var.lambda_info.function_name}"
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.sg_ids
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.apigw_execution_arn}/*/${var.lambda_info.method}${var.lambda_info.path}"
}
