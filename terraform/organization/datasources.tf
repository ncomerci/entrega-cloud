# ---------------------------------------------------------------------------
# Main resources
# ---------------------------------------------------------------------------

data "aws_region" "current" {
  provider = aws.aws
}

data "aws_caller_identity" "current" {
  provider = aws.aws
}

# data "template_file" "userdata" {
#  template = templatefile("../resources/html/index.html", {ENDPOINT = "${module.apigw.invoke_url}"}) 
# }

data "template_file" "userdata" {
  template = "${file("../resources/html/index.html")}"
  vars = {
    ENDPOINT = "${module.apigw.invoke_url}"
  }
}