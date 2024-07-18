resource "aws_instance" "bastion" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  key_name      = var.key_name

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "private" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  key_name      = var.key_name
  security_groups = [var.private_sg_id]

  root_block_device {
    volume_size = 25
  }

  tags = {
    Name = "private-server"
  }
}
