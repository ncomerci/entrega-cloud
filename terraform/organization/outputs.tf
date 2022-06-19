output "api_endpoint" {
  value = module.apigw.invoke_url
}

output "cognito_endpoint" {
  value = "https://${module.cognito.domain}.auth.${data.aws_region.current.name}.amazoncognito.com/signup?response_type=code&client_id=${module.cognito.client_id}&redirect_uri=${module.cognito.callback_url}"
}