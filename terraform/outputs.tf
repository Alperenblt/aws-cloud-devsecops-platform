output "vpc_id" {
  description = "ID of the Terraform lab VPC"
  value       = module.networking.vpc_id
}

output "s3_bucket_name" {
  description = "Name of the Terraform-managed S3 bucket"
  value       = module.storage.bucket_name
}
