locals {
  bucket_name = "test-mhs.com"
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
      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name = "www.${local.bucket_name}"
    }
  }
}