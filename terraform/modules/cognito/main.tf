resource "aws_cognito_user_pool" "this" {
    name    = var.pool_name
 
    alias_attributes = [ 
        "email",
        "preferred_username", ]
    
    password_policy {
        minimum_length = 8
        require_lowercase = true
        require_symbols = false
        require_numbers = true
        require_uppercase = true
        temporary_password_validity_days = 7
    }

    account_recovery_setting {
        recovery_mechanism {
            name = "verified_email"
            priority = 1
        }
    }

    email_configuration {
        email_sending_account = "COGNITO_DEFAULT"
    }

    verification_message_template {
        email_message = "Your code is {####}"
        email_subject = "Verifque su cuenta"
    }

    auto_verified_attributes             = ["email"]

}

resource "aws_cognito_user_pool_client" "this" {
    name = var.client_name
    user_pool_id                         = aws_cognito_user_pool.this.id

    callback_urls                        = ["https://${var.redirect_uri}/"]

    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_flows                  = ["code"]
    allowed_oauth_scopes                 = ["email", "openid", "phone"]
    supported_identity_providers         = ["COGNITO"]

    
}

resource "aws_cognito_user_pool_domain" "this" {
    domain       = var.domain_name
    user_pool_id = aws_cognito_user_pool.this.id
}
