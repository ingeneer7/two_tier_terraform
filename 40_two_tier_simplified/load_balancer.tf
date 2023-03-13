// Create a load balancer in a public subnet
resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "My Load Balancer"
  }
}

// Create an HTTP listener that forwards traffic to the web target group
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.web_target_group.arn
    type             = "forward"
  }
}

// Create a target group for the web servers
resource "aws_lb_target_group" "web_target_group" {
  name        = "web-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.my_vpc.id
  health_check {
    timeout  = 2
    interval = 5
    path     = "/"
  }

  tags = {
    Name = "Web Target Group"
  }
}

// Register the web servers with the target group
resource "aws_lb_target_group_attachment" "web_target_group_attachment_1" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.web_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_target_group_attachment_2" {
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id        = aws_instance.web_2.id
  port             = 80
}