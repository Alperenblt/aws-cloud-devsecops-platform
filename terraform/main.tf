moved {
  from = aws_vpc.terraform_lab_vpc
  to   = module.networking.aws_vpc.terraform_lab_vpc
}

moved {
  from = aws_subnet.terraform_public_subnet_1
  to   = module.networking.aws_subnet.terraform_public_subnet_1
}

moved {
  from = aws_internet_gateway.terraform_igw
  to   = module.networking.aws_internet_gateway.terraform_igw
}

moved {
  from = aws_route_table.terraform_public_rt
  to   = module.networking.aws_route_table.terraform_public_rt
}

moved {
  from = aws_route_table_association.terraform_public_assoc
  to   = module.networking.aws_route_table_association.terraform_public_assoc
}

moved {
  from = aws_security_group.terraform_web_sg
  to   = module.compute.aws_security_group.terraform_web_sg
}

moved {
  from = aws_vpc_security_group_ingress_rule.allow_http
  to   = module.compute.aws_vpc_security_group_ingress_rule.allow_http
}

moved {
  from = aws_vpc_security_group_egress_rule.allow_outbound
  to   = module.compute.aws_vpc_security_group_egress_rule.allow_outbound
}

moved {
  from = aws_s3_bucket.terraform_lab_bucket
  to   = module.storage.aws_s3_bucket.terraform_lab_bucket
}

moved {
  from = aws_s3_bucket_public_access_block.terraform_lab_bucket_public_access
  to   = module.storage.aws_s3_bucket_public_access_block.terraform_lab_bucket_public_access
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.terraform_lab_bucket_encryption
  to   = module.storage.aws_s3_bucket_server_side_encryption_configuration.terraform_lab_bucket_encryption
}

moved {
  from = aws_s3_bucket_versioning.terraform_lab_bucket_versioning
  to   = module.storage.aws_s3_bucket_versioning.terraform_lab_bucket_versioning
}

moved {
  from = aws_s3_bucket_lifecycle_configuration.terraform_lab_bucket_lifecycle
  to   = module.storage.aws_s3_bucket_lifecycle_configuration.terraform_lab_bucket_lifecycle
}

module "networking" {
  source = "./modules/networking"
}

module "compute" {
  source = "./modules/compute"

  vpc_id     = module.networking.vpc_id
  subnet_id  = module.networking.public_subnet_id
  create_ec2 = var.create_ec2
}

module "storage" {
  source = "./modules/storage"
}