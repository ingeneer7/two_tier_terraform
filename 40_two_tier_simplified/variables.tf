variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_web_subnet_cidr_blocks" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_rds_subnet_cidr_blocks" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "ami_id" {
  default = "ami-005f9685cb30f234b" # Amazon AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "my-pem-key"
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "myuser"
}

variable "db_password" {
  default = "mypassword"
}
