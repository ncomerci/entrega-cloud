# --------------------------------------------------------------------
# Amazon API Gateway output
# --------------------------------------------------------------------

output "execution_arn" {
    description = "The APIGW execution ARN"
    value       = aws_api_gateway_deployment.this.execution_arn
}

output "invoke_url" {
    description = "The APIGW invoke url"
    value       = aws_api_gateway_stage.this.invoke_url
}

output "source_arn" {
    description = "The APIGW source ARN"
    # value       = "arn:aws:execute-api:${var.aws_region_name}:${var.account_id}:${aws_api_gateway_rest_api.this.id}/*/${aws_api_gateway_method.this.http_method}${aws_api_gateway_resource.this.path}"
    value       = "arn:aws:execute-api:${var.aws_region_name}:${var.account_id}:${aws_api_gateway_rest_api.this.id}/*/*"
}

output "domain_name" {
    description = "API GW domain_name"
    value = replace(aws_api_gateway_stage.this.invoke_url, "/^https?://([^/]*).*/", "$1")
}

output "name" {
    description = "API GW name"
    value = aws_api_gateway_stage.this.name
}