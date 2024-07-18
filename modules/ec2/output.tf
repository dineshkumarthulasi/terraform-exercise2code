output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_server_id" {
  value = aws_instance.private.id
}

output "private_server_private_ip" {
  value = aws_instance.private.private_ip
}




