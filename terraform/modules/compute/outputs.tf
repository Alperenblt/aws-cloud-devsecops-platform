output "security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.terraform_web_sg.id
}
