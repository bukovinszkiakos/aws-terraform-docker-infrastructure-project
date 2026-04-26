output "instance_ids" {
  value = aws_instance.server[*].id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}