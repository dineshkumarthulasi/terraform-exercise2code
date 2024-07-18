output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}
output "private_server_private_ip" {
  value = module.ec2.private_server_private_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}
