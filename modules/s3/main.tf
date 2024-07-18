resource "aws_s3_bucket" "lambda_trigger_bucket" {
  bucket = var.bucket_name
}

