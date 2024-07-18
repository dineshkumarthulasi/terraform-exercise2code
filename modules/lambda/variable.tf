variable "lambda_zip_path" {
  description = "Path to the Lambda zip file"
  type        = string
  default     = "lambda-function.zip"
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to trigger the Lambda function"
  type        = string
}
