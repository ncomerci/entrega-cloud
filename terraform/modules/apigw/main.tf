# ---------------------------------------------------------------------------
# Amazon API Gateway
# ---------------------------------------------------------------------------

module "global_settings" {
  source = "../global"
}

resource "aws_api_gateway_rest_api" "this" {

  name        = local.name
  description = local.description

  body = data.template_file.apigw-openapi.rendered

  tags = {
    name       = local.tags.name
    author     = module.global_settings.author
    version    = module.global_settings.version
    university = module.global_settings.university
    subject    = module.global_settings.subject
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
  stage_name    = module.global_settings.stage_name
}

data "template_file" "apigw-openapi" {
  template = var.template_file

  vars = var.template_file_vars
}

