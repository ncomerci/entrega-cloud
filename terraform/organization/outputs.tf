# ---------------------------------------------------------------------------
# Root Outputs
# ---------------------------------------------------------------------------

output "api_endpoint" {
  value = module.apigw.invoke_url
}

output "cognito_endpoint" {
  value = module.cognito.endpoint
}

output "endpoints" {
  value = data.template_file.userdata.rendered
}