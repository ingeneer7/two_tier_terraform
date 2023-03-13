// Create a bastion host in a public subnet
resource "aws_instance" "bastion_host" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion Host"
  }
}

// Create an EC2 instance for the web server tier
resource "aws_instance" "web_1" {
  ami                    = var.ami_id
  instance_type          = "t2.small"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.private_web_subnet_1.id

  user_data = templatefile("${path.cwd}/script.sh", {
    rds_endpoint = aws_db_instance.rds_instance.endpoint
    db_username  = var.db_username
    db_password  = var.db_password
    db_name      = var.db_name
  })

  tags = {
    Name = "Web Server 1"
  }
  depends_on = [aws_db_instance.rds_instance]
}



resource "aws_instance" "web_2" {
  ami           = var.ami_id
  instance_type = "t2.small"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.private_web_subnet_2.id

  user_data = templatefile("${path.cwd}/script.sh", {
    rds_endpoint = aws_db_instance.rds_instance.endpoint
    db_username  = var.db_username
    db_password  = var.db_password
    db_name      = var.db_name
  })


  tags = {
    Name = "Web Server 2"
  }
  depends_on = [aws_db_instance.rds_instance]
}
