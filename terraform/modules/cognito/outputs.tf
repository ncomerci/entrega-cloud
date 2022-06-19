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

output "callback_url" {
  value = one(aws_cognito_user_pool_client.this.callback_urls)
}