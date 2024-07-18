resource "null_resource" "zip_lambda" {
  provisioner "local-exec" {
    command = <<EOT
    zip -j ${path.module}/lambda-function.zip ${path.module}/${var.lambda_zip_path}
    EOT
  }
}

resource "aws_lambda_function" "lambda_function" {
  depends_on      = [null_resource.zip_lambda]
  filename        = "${path.module}/lambda-function.zip"
  function_name   = var.function_name
  role            = aws_iam_role.lambda_role.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.8"
  source_code_hash = filebase64sha256("${path.module}/lambda-function.zip")

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.bucket_name}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  inline_policy {
    name   = "lambda-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ]
          Effect   = "Allow"
          Resource = "arn:aws:logs:*:*:*"
        },
        {
          Action = "s3:GetObject"
          Effect = "Allow"
          Resource = "arn:aws:s3:::${var.bucket_name}/*"
        }
      ]
    })
  }
}