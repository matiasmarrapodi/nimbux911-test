variable cidr_block {
description = " cidr_block"
default = "172.16.0.0/16"
}

variable ami {
    default = "ami-0fb653ca2d3203ac1" 
}

variable "region" {
default = "us-east-2"

}
variable "instance_type" {
    default = "t3.micro"
}


variable "vpc_cidr" {}

variable "public_subnet_1_cidr" {}

variable "public_subnet_2_cidr" {}

variable "private_subnet_cidr" {}

variable "key_name" {}