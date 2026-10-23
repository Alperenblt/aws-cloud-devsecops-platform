output "vpc_id" {
  description = "The ID of the VPC managed by the networking module"
  value       = aws_vpc.terraform_lab_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet managed by the networking module"
  value       = aws_subnet.terraform_public_subnet_1.id
}