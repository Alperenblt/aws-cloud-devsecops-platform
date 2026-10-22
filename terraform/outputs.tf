output "vpc_id" {
  description = "ID of the Terraform lab VPC"
  value       = aws_vpc.terraform_lab_vpc.id
}

output "s3_bucket_name" {
  description = "Name of the Terraform-managed S3 bucket"
  value       = aws_s3_bucket.terraform_lab_bucket.id
}
