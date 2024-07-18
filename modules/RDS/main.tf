resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "14"
  instance_class       = "db.t4g.large"  # Use a supported instance class
  identifier           = var.db_name
  username             = var.username
  password             = var.password
  # parameter_group_name = "default.postgres13"
  publicly_accessible  = false
  # vpc_security_group_ids = [aws_security_group.db_sg.id]
  # db_subnet_group_name = aws_db_subnet_group.main1.name

  tags = {
    Name = "rds-instance"
  }
}
