variable cidr_block {
description = " cidr_block"
default = "172.16.0.0/16"
}

variable "region" {
default = "us-east-1"

}
variable "instance_type" {
    default = "t3.micro"
}


variable "vpc_cidr" {}

variable "public_subnet_cidr" {}

variable "private_subnet_apache_cidr" {}

variable "private_subnet_nginx_cidr" {}