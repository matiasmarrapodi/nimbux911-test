data "aws_availability_zones" "available" {
  state = "available"
}

# Create a VPC
resource "aws_vpc" "laboratorio_vpc" {
  cidr_block = var.vpc_cidr
   enable_dns_support   = true
   enable_dns_hostnames = true

  tags = {
    Name = "laboratorio-vpc"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.laboratorio_vpc.id

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private_subnet_apache" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.private_subnet_apache_cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-apache2"
  }
}

resource "aws_subnet" "private_subnet_nginx" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.private_subnet_nginx_cidr
  availability_zone = "us-east-1c"

  tags = {
    Name = "private-subnet-nginx"
  }
}

resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    "Name" = "nat_gateway"
  }
}



resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.laboratorio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.servers_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_rt_asso" {
  subnet_id = aws_subnet.private_subnet_apache.id
  route_table_id = aws_route_table.private_rt.id
}