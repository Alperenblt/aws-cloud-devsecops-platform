resource "aws_s3_bucket" "terraform_lab_bucket" {
  bucket_prefix = "alperen-terraform-lab-"

  tags = {
    Name        = "terraform-lab-bucket"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_lab_bucket_public_access" {
  bucket = aws_s3_bucket.terraform_lab_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_lab_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_lab_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_lab_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_lab_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "terraform_lab_bucket_lifecycle" {
  bucket = aws_s3_bucket.terraform_lab_bucket.id

  rule {
    id     = "delete-old-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.terraform_lab_bucket_versioning
  ]
}
