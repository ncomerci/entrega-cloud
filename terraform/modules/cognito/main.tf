resource "aws_cognito_user_pool" "pool" {
    name = var.pool_name

    alias_attributes = [ 
        "email",
        "preferred_username", ]
    
    password_policy {
        minimum_length = 8
        require_lowercase = true
        require_symbols = false
        require_numbers = true
        require_uppercase = true
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

}

resource "aws_cognito_user_pool_client" "user_client" {
    name = var.client_name
    user_pool_id = aws_cognito_user_pool.pool.id

    callback_urls                        = ["https://itba-montegrande-health-system.com.s3-website-us-east-1.amazonaws.com/"]

    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_flows                  = ["code"]
    allowed_oauth_scopes                 = ["email", "openid"]
    supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "cognito_domain" {
    domain       = var.domain_name
    user_pool_id = aws_cognito_user_pool.pool.id
}
