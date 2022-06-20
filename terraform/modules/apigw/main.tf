# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

resource "aws_api_gateway_rest_api" "this" {
 
  name           = "AWSAPIGateway-MHS"
  description    = "MHS Api Gateway"

  body           = "${data.template_file.apigw-openapi.rendered}"

  tags = {
      name       = "Api Gateway MHS"
      author     = "MHS Grupo 1"
      version    = 1
      university = "ITBA"
      subject    = "Cloud Computing" 
  } 
}


resource "aws_api_gateway_deployment" "this" {

  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
 
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "production"
}

data "template_file" "apigw-openapi" {
  template = var.template_file

  vars = var.template_file_vars
}

