# ------------------------------------------------------------------------
# Amazon Lambda variables
# ------------------------------------------------------------------------

# variable "function_name" {
#   type        = string
#   description = "The name of the Lambda function"
# }

# variable "filename" {
#   type        = string
#   description = "The filename containing the function for lambda to run"
# }

variable "account_id" {
  type = string
  description = "The current Accound ID"
}

variable "local_path" { 
   type = string
  description = "Local path"
} 

variable "api_gw_source_arn" {
  type = string
  description = "source ARN"
}