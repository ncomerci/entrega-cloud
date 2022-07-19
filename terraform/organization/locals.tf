# ---------------------------------------------------------------------------
# Root Locals
# ---------------------------------------------------------------------------

locals {
  # ---------------------------------------------------------------------------
  # VPC
  # ---------------------------------------------------------------------------

  vpc_cidr = "10.0.0.0/16"
  az_total = 2
  vpc_endpoints = {
    s3 = {
      service_name  = "com.amazonaws.us-east-1.s3"
      endpoint_name = "mhs-s3-vpc-endpoint"
    }
    dynamodb = {
      service_name  = "com.amazonaws.us-east-1.dynamodb"
      endpoint_name = "mhs-dynamodb-vpc-endpoint"
    }
  }

  # ---------------------------------------------------------------------------
  # S3
  # ---------------------------------------------------------------------------

  bucket_name = "montegrande-health-system.bytedev.com.ar"
  path        = "../resources"

  s3 = {

    # 1 - Website
    website = {
      bucket_name = local.bucket_name
      is_website  = true
      objects = [for file in fileset("../resources/html", "**/*.*") :
        {
          key          = file
          source       = "../resources/html/${file}"
          etag         = filemd5("../resources/html/${file}")
          content_type = lookup(local.mime_types, regex("\\.[^.]+$", file), null)

        }
      ]
      website_config = {
        index_document = ["index.html"]
        error_document = ["error.html"]
      }

    }

    # 2 - WWW Website
    www-website = {
      bucket_name     = "www.${local.bucket_name}"
      count_condition = "web"
      is_website      = true
      website_config = {
        redirect = ["redirect"]
      }
    }

    # 3 - Logs
    logs = {
      bucket_name    = "mhs-logs-itba-cp-g1"
      bucket_acl     = "log-delivery-write"
      is_log         = true
      logs_from      = local.bucket_name
      website_config = {}
    }

    # 4 - Medical Records 
    medical-records = {
      bucket_name = "mhs-medical-records-itba-cp-g1"
      objects = [for record in fileset("../resources/medical-records", "**/*.*") :
        {
          key    = "user1/${record}"
          source = "../resources/medical-records/${record}"
          etag   = filemd5("../resources/medical-records/${record}")
        }
      ]
      website_config = {}
      encrypt        = true
    }

  }

  mime_types = jsondecode(file("${local.path}/mime.json"))

  # ---------------------------------------------------------------------------
  # Lambda
  # ---------------------------------------------------------------------------

  lambdas = {
    "list-medical-records" = {
      filename      = "${local.path}/lambda/lambda_list_medical_records.zip"
      function_name = "getMedicalRecords"
      method        = "GET"
      handler       = "lambda_list_medical_records.main"
      path          = "/medical-records"
      part_path     = "medical-records"
    }
    "new-medical-record" = {
      filename      = "${local.path}/lambda/lambda_new_medical_record.zip"
      function_name = "postMedicalRecord"
      method        = "POST"
      handler       = "lambda_new_medical_record.main"
      path          = "/medical-records"
      part_path     = "medical-records"
    }
    "post-appointment" = {
      filename      = "${local.path}/lambda/lambda_post_appointment.zip"
      function_name = "postAppointment"
      method        = "POST"
      handler       = "lambda_post_appointment.main"
      path          = "/appointments"
      part_path     = "appointments"
    }
    "get-appointment" = {
      filename      = "${local.path}/lambda/lambda_get_appointment.zip"
      function_name = "getAppointment"
      method        = "GET"
      handler       = "lambda_get_appointment.main"
      path          = "/appointments"
      part_path     = "appointments"
    }
  }

  # ---------------------------------------------------------------------------
  # DynamoDB
  # --------------------------------------------------------------------------- 

  dynamodb = {
    users = {
      name     = "users-table"
      hash_key = "user-id"
    }

    appointments = {
      name     = "appointments-table"
      hash_key = "appointment-id"
    }
  }

  # ---------------------------------------------------------------------------
  # Cognito
  # ---------------------------------------------------------------------------

  cognito = {
    pool_name   = "mhs-user-pool"
    domain_name = "montegrande-health-system-cpg1"
    client_name = "mhs-client"
  }

  # ---------------------------------------------------------------------------
  # API Gateway
  # ---------------------------------------------------------------------------

  apigateway = {
    name        = "AWSAPIGateway-MHS"
    description = "MHS Api Gateway"
  }

}