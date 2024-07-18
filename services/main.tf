module "network" {
  source = "../modules/network"
}

module "security_groups" {
  source = "../modules/security_groups"
  vpc_id = module.network.vpc_id
  subnet_ids = module.network.private_subnets
}

module "ec2" {
  source          = "../modules/ec2"
  public_subnet_id = element(module.network.public_subnets, 0)
  private_subnet_id = element(module.network.private_subnets, 0)
  bastion_sg_id    = module.security_groups.bastion_sg_id
  private_sg_id    = module.security_groups.private_sg_id
  key_name         = "dineshkeypair"
}


module "cloudwatch" {
  source       = "../modules/CloudWatch"
  instance_id  = module.ec2.private_server_id
  sns_topic_arn = module.sns.sns_topic_arn
}

module "sns" {
  source        = "../modules/SNS"
  email_address = "dineshraman.t@gmail.com"
}

module "s3" {
  source      = "../modules/s3"
  bucket_name = "terraform2bucket"
}

module "rds" {
  source             = "../modules/RDS"
  db_name            = "mydb"
  username           = "myuser"
  password           = "mypassword"
  db_security_group  = module.security_groups.db_sg_id
  subnet_ids         = module.network.private_subnets
}


module "lambda" {
  source          = "../modules/lambda"
  lambda_zip_path = "lambda-function-zip"
  function_name   = "my_lambda_function"
  bucket_name     = "lambda-trigger-bucket"
}
