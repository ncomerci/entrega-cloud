output "api_endpoint" {
  value = module.apigw.invoke_url
}

output "cognito_endpoint" {
  value = module.cognito.endpoint
}