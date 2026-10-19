output "vpc_id" {
  description = "ID of the Terraform lab VPC"
  value       = aws_vpc.terraform_lab_vpc.id
}