# --------------------------------------------------------------------
# Amazon API Gateway output
# --------------------------------------------------------------------

output "execution_arn" {
    description = "The APIGW execution ARN"
    value       = aws_api_gateway_rest_api.this.execution_arn
}

output "invoke_url" {
    description = "The APIGW invoke url"
    value       = aws_api_gateway_stage.this.invoke_url
}

output "domain_name" {
    description = "API GW domain_name"
    value = replace(aws_api_gateway_stage.this.invoke_url, "/^https?://([^/]*).*/", "$1")
}

output "name" {
    description = "API GW name"
    value = aws_api_gateway_rest_api.this.name
}

output "apigw_id" {
    description = "API GW id"
    value = aws_api_gateway_rest_api.this.id
}