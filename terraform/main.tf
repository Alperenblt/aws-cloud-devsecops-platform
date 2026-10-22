resource "aws_vpc" "terraform_lab_vpc" {
  cidr_block = "10.20.0.0/16"

  tags = {
    Name = "terraform-lab-vpc"
  }
}

resource "aws_subnet" "terraform_public_subnet_1" {
  vpc_id            = aws_vpc.terraform_lab_vpc.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "terraform-public-subnet-1"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_lab_vpc.id

  tags = {
    Name = "terraform-lab-igw"
  }
}

resource "aws_route_table" "terraform_public_rt" {
  vpc_id = aws_vpc.terraform_lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }
  tags = {
    Name = "terraform-public-route-table"
  }

}

resource "aws_route_table_association" "terraform_public_assoc" {
  subnet_id      = aws_subnet.terraform_public_subnet_1.id
  route_table_id = aws_route_table.terraform_public_rt.id
}

resource "aws_security_group" "terraform_web_sg" {
  name        = "terraform-web-sg"
  description = "Security group for Nginx web server"
  vpc_id      = aws_vpc.terraform_lab_vpc.id

  tags = {
    Name = "terraform-web-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terraform_web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.terraform_web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "terraform_web_ec2" {
  count = var.create_ec2 ? 1 : 0

  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.terraform_public_subnet_1.id
  vpc_security_group_ids = [
    aws_security_group.terraform_web_sg.id
  ]
  associate_public_ip_address = true
  user_data                   = file("${path.module}/userdata.sh")
  tags = {
    Name = "terraform-web-ec2"
  }
}

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