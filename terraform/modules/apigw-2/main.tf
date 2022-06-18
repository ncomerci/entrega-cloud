# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "this" {
  # provider = aws.aws
  name        = "AWSAPIGateway-MHS"
  description = "MHS Api Gateway"

  body           = "${data.template_file.apigw-openapi.rendered}"
}


resource "aws_api_gateway_deployment" "this" {
  # provider = aws.aws

  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  # provider = aws.aws

  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "production"
}

data "template_file" "apigw-openapi" {
  template = "${file("../resources/apigw-openapi.yaml")}"


  vars = {
    lambda_identity_arn           = var.invoke_arn
    aws_region                    = var.aws_region_name
    # lambda_identity_timeout = var.lambda_identity_timeout
    # invoke_url              = aws_api_gateway_stage.this.invoke_url
  }

}

