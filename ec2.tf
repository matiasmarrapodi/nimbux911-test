resource "aws_instance" "apache" {
  ami             = "ami-0e1d30f2c40c4c701" 
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]

  user_data = "${file("install_apache.sh")}"

  tags = {
    Name = "apache"
  }

  volume_tags = {
    Name = "apache"
  } 
}
