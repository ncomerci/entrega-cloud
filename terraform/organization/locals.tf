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
      path        = "../resources"

      objects = {
        error = {
          filename     = "html/error.html"
          content_type = "text/html"
        }
        css = {
          filename     = "html/main.css"
          content_type = "text/html"
        }
      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}"
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
      filename      = "${local.path}/lambda/lambda_post_appointment.zip"
      function_name = "getAppointment"
      method        = "GET"
      handler       = "lambda_get_appointment.main"
      path          = "/appointments"
      part_path     = "appointments"
    }
  }
  
}