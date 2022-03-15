# Create a VPC
resource "aws_vpc" "laboratorio_vpc" {
  cidr_block = var.vpc_cidr

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

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-2b"

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.laboratorio_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-2a"

  tags = {
    Name = "private-subnet"
  }
}


resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnet_1.id
  tags = {
    "Name" = "nat_gateway"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.laboratorio_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.laboratorio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}