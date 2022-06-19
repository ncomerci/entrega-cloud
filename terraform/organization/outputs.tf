output "api_endpoint" {
  value = module.apigw.invoke_url
}

output "cognito_endpoint" {
  value = module.cognito.client_id
}

output "cognito_endpoint2" {
  value = module.cognito.url
}