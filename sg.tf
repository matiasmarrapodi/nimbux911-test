resource "aws_security_group" "alb" {
  name = "alb-security-group"
  vpc_id = aws_vpc.laboratorio_vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acces port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
   
  }
}   

resource "aws_security_group" "sg" {
  name = "laboratorio-sg"
  vpc_id = aws_vpc.laboratorio_vpc.id

  ingress {
    security_groups = [aws_security_group.alb.id]
    description     = "Acces port alb"
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  } 
}
