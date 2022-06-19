# ------------------------------------------------------------------------
# Amazon Lambda variables
# ------------------------------------------------------------------------

variable "account_id" {
  type = string
  description = "The current Accound ID"
}

variable "local_path" { 
   type = string
  description = "Local path"
} 

variable "lambda_info" {
  type = map(string)
  description = "Contains all necesary lambda info"
}

variable "apigw_execution_arn" {
    type = string
    description = "API GW execution ARN"
}