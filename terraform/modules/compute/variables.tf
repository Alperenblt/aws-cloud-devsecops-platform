variable "vpc_id" {
  description = "VPC ID where the EC2 instance and security group will be created"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for the EC2 instance"
  type        = string
}

variable "create_ec2" {
  description = "Whether to create the web EC2 instance"
  type        = bool
  default     = false
}
