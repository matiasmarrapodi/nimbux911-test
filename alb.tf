####################################################
# Application Load balancer
####################################################

resource "aws_lb" "alb" {
  name               = "laboratorio"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}


####################################################
# Target Group Attachment with Instance
####################################################

resource "aws_lb_target_group" "this" {
  name     = "laboratorio-alb-target-group"
  port     = 80
  vpc_id   = aws_vpc.laboratorio_vpc.id
  protocol = "HTTP"

  health_check {
    enabled  = true
    matcher  = "200"
    path     = "/"
    port     = "80"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "ec2-apache" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.apache.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2-nginx" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}

####################################################
# Listner
####################################################
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}