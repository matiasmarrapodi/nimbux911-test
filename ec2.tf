resource "aws_instance" "apache" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.sg.id]
  key_name = var.key_name
  user_data = "${file("install_apache.sh")}"

  tags = {
    Name = "apache"
  }

  volume_tags = {
    Name = "apache"
  } 
}

resource "aws_instance" "nginx" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.sg.id]
  key_name = var.key_name

  user_data = "${file("install_nginx.sh")}"

  tags = {
    Name = "nginx"
  }

  volume_tags = {
    Name = "nginx"
  } 
}

