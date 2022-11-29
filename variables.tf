variable "region" {
  default = ["eu-west-2"]
  description  = "AWS Region"
}

# VPC creation and components
variable "cidr_block" {
  default = "10.0.0.0/16" 
  description  = "VPC cidr"
}

# public subnet components
variable "Test-public-sub1" {
  default = "10.0.1.0/24" 
  description  = "Test-public cidr"
}

variable "Test-public-sub2" {
  default = "10.0.2.0/24" 
  description  = "Test-public cidr"
}

# private subnet components
variable "Test-priv-sub1" {
  default = "10.0.3.0/24" 
  description  = "Test-priv cidr"
}

variable "Test-priv-sub2" {
  default = "10.0.4.0/24" 
  description  = "Test-priv cidr"
}

# creating internet gateway
variable "cidr_block-Test-igw-asso" {
default = "0.0.0.0/0"
description = "aws internet gateway"
}

# create security group for the ec2 instance
variable "Test-sec-group-aws_security_group" {
default = "allow access on port 80 and 22"
description = "Test security group"
}

# creating an ec2 server
variable "Test-server-1-aws_instance" {
  default = "ami-0f540e9f488cfa27d"
  description = "Test-server-1"
}

variable "Test-server-2-aws_instance" {
  default = "ami-0f540e9f488cfa27d"
  description = "Test-server-2"
}
