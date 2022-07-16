# ---------------------------------------------------------------------------
# AWS Lambda resources
# ---------------------------------------------------------------------------

# We need to create it just one time, not inside foreach 
resource "aws_security_group" "this" {

  provider = aws.aws

  name        = "lambda-sg"
  description = "Generic Lambda Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

module "lambda" {
  for_each = local.lambdas
  providers = {
    aws = aws.aws
  }

  source              = "../modules/lambda"
  local_path          = local.path
  lambda_info         = each.value
  account_id          = data.aws_caller_identity.current.account_id
  apigw_execution_arn = module.apigw.execution_arn
  subnet_ids          = module.vpc.subnet_ids
  sg_ids              = [aws_security_group.this.id]

}
