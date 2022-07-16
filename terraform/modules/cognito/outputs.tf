# ---------------------------------------------------------------------------
# Amazon Cognito outputs
# ---------------------------------------------------------------------------

output "endpoint" {
  value = "https://${var.domain_name}.auth.${var.aws_region_name}.amazoncognito.com/signup?response_type=code&client_id=${aws_cognito_user_pool_client.this.id}&redirect_uri=${one(aws_cognito_user_pool_client.this.callback_urls)}"
}