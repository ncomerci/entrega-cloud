# --------------------------------------------------------------------
# Amazon Lambda output
# --------------------------------------------------------------------

output "invoke_arn" {
  description = "The lambda function's invoke ARN"
  value       = aws_lambda_function.this.invoke_arn
}

# output "http_method" {
#     description = "The lambda function's http method"
#     value       = aws_lambda_function.this.http_method
# }

# output "path" {
#     description = "The path to call the lambda function"
#     value       = aws_lambda_function.this.path
# }

output "function_name" {
  description = "The lambda function's name"
  value       = aws_lambda_function.this.function_name
}