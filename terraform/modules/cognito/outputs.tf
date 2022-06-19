# ---------------------------------------------------------------------------
# Amazon Cognito outputs
# ---------------------------------------------------------------------------

output "client_id" {
  description = "Cognito client ID"
  value = "${aws_cognito_user_pool_client.this.id}"
}

output "domain" {
  value = "${aws_cognito_user_pool.this.domain}"
}