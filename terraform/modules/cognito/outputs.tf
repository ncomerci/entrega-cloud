# ---------------------------------------------------------------------------
# Amazon Cognito outputs
# ---------------------------------------------------------------------------

output "cognito_client_id" {
  description = "Cognito client ID"
  value = "${aws_cognito_user_pool_client.this.id}"
}