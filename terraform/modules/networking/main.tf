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