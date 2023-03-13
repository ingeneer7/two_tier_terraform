// Create a NAT gateway in a public subnet
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "My NAT Gateway"
  }
}

// Create an EIP for the NAT gateway
resource "aws_eip" "my_eip" {
  vpc = true

  tags = {
    Name = "My EIP"
  }
}

// Update the private route table to use the NAT gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

// Associate the private subnets with the private route table
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_web_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_web_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_3_association" {
  subnet_id      = aws_subnet.private_rds_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_4_association" {
  subnet_id      = aws_subnet.private_rds_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}



