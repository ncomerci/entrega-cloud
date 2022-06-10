# ---------------------------------------------------------------------------
# Variables
# ---------------------------------------------------------------------------

variable "montegrande_website_bucket_name" {
    description = "Bucket name for Montegrande S3 website"
    type        = string
    default     = "montegrande-healthcare-system-website"
}