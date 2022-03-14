resource "aws_instance" "apache" {
  ami             = "ami-0fb653ca2d3203ac1" 
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet_apache.id
  security_groups = [aws_security_group.sg.id]
  user_data = "${file("install_apache.sh")}"

  tags = {
    Name = "apache"
  }

  volume_tags = {
    Name = "apache"
  } 
}

resource "aws_instance" "nginx" {
  ami             = "ami-0fb653ca2d3203ac1"
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet_apache.id
  security_groups = [aws_security_group.sg.id]

  user_data = "${file("install_nginx.sh")}"

  tags = {
    Name = "nginx"
  }

  volume_tags = {
    Name = "nginx"
  } 
}

