// Create VPC with the specified CIDR block
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "My VPC"
  }
}

// Create two public subnets in different availability zones
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[0]
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_blocks[1]
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Public Subnet 2"
  }
}

// Create two private subnets for the web server tier in different availability zones
resource "aws_subnet" "private_web_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_web_subnet_cidr_blocks[0]
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Private Web Subnet 1"
  }
}

resource "aws_subnet" "private_web_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_web_subnet_cidr_blocks[1]
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Private Web Subnet 2"
  }
}

// Create two private subnets for the RDS tier in different availability zones
resource "aws_subnet" "private_rds_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_rds_subnet_cidr_blocks[0]
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Private RDS Subnet 1"
  }
}

resource "aws_subnet" "private_rds_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_rds_subnet_cidr_blocks[1]
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Private RDS Subnet 2"
  }
}
