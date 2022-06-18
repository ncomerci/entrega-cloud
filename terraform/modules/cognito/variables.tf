# ---------------------------------------------------------------------------
# Amazon Cognito variables
# ---------------------------------------------------------------------------

variable "pool_name" {
  type          = string
  description   = "Name of the user pool."
}

variable "client_name" {
  type          = string
  description   = "Name of the application client."
}

variable "domain_name" {
  type = string
  description = "For custom domains, this is the fully-qualified domain name, such as auth.example.com. For Amazon Cognito prefix domains, this is the prefix alone, such as auth."
}

variable "redirect_uri" {
  type = string
  description = "website endpoint to redirect"
}