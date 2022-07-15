# ---------------------------------------------------------------------------
# Root Locals
# ---------------------------------------------------------------------------

locals {
  ################################################
  ## VPC
  vpc_cidr = "10.0.0.0/16"
  az_total = 2

  ################################################
  ## S3
  bucket_name = "montegrande-health-system.bytedev.com.ar"
  path        = "../resources"

  s3 = {

    # 1 - Website
    website = {
      bucket_name = local.bucket_name
      is_website = true
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}"
      count_condition = "web"
      is_website = true
    }

    # 3 - Logs
    logs = { 
      bucket_name = "mhs-logs-itba-cp-g1"
      bucket_acl  = "log-delivery-write" 
      is_log = true
      logs_from = local.bucket_name
    } 

    # 4 - Medical Records 
    medical-records = { 
      bucket_name = "mhs-medical-records-itba-cp-g1" 
      objects = { 
        mock-pdf-record = { 
          key = "user1/medical-record.pdf"
          source = "../resources/docs/medical_record.pdf"
        }
        mock-jpg-record = { 
          key = "user1/radiografia-mano.jpg"
          source = "../resources/images/radiografia-mano.jpg"
        }
        
      }
    } 
  }
  
  mime_types = jsondecode(file("${local.path}/mime.json"))

  ################################################
  ## Lambdas
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

  ################################################
  ## DynamoDB 

  dynamodb = { 
    users = { 
      name           = "users-table" 
      hash_key       = "user-id"
    }

    appointments = { 
      name           = "appointments-table"
      hash_key       = "appointment-id"
    }
  }

}