# ---------------------------------------------------------------------------
# Main resources
# ---------------------------------------------------------------------------

data "aws_region" "current" {
  provider = aws.aws
}

data "aws_caller_identity" "current" {
  provider = aws.aws
}

data "template_file" "userdata" {

  template = templatefile(
    "../resources/html/index.html.tftpl",
    {
      ENDPOINT         = "${module.apigw.invoke_url}",
      COGNITO_ENDPOINT = "${module.cognito.endpoint}"
  })
}