module "waf" { 
providers = {
    aws = aws.aws
  }
  source = "../modules/waf"

}