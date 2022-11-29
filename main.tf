# VPC creation and components
resource "aws_vpc" "Prod-rock-VPC" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Prod-rock-VPC"
  }
}

# public subnet components
resource "aws_subnet" "Test-public-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.Test-public-sub1

  tags = {
    Name = "Test-public-sub1"
  }
}

resource "aws_subnet" "Test-public-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.Test-public-sub2

  tags = {
    Name = "Test-public-sub2"
  }
}

# private subnet components
resource "aws_subnet" "Test-priv-sub1" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.Test-priv-sub1

  tags = {
    Name = "Test-priv-sub1"
  }
}

resource "aws_subnet" "Test-priv-sub2" {
  vpc_id     = aws_vpc.Prod-rock-VPC.id
  cidr_block = var.Test-priv-sub2

  tags = {
    Name = "Test-priv-sub2"
  }
}

# creating public route table
resource "aws_route_table" "Test-pub-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-pub-route-table"
  }
}


# creating private route table
resource "aws_route_table" "Test-priv-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-priv-route-table "
  }
}

# creating public route table association
resource "aws_route_table_association" "pub-RT-class-1" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-pub-route-table.id
}

resource "aws_route_table_association" "pub-RT-clas-2" {
  subnet_id      = aws_subnet.Test-public-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

# creating private route table association
resource "aws_route_table_association" "priv-RT-class-1" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

resource "aws_route_table_association" "priv-RT-class-2" {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-priv-route-table.id
}

# creating internet gateway
resource "aws_internet_gateway" "Prod-rock-VPC" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Prod-rock-VPC"
  }
}

# internet  gateway route
resource "aws_route" "Test-igw-asso"{
  route_table_id  = aws_route_table.Test-pub-route-table.id
  destination_cidr_block  = var.cidr_block-Test-igw-asso
  gateway_id       = aws_internet_gateway.Prod-rock-VPC.id
}


# elastic ip address components
resource "aws_eip" "Test-eip" {
  vpc   = true
}

# creating NAT gateway
resource "aws_nat_gateway" "Test-Nat-gateway-1" {
  subnet_id = aws_subnet.Test-priv-sub1.id
  connectivity_type = "private"

  tags = {
    Name = "Test-Nat-gateway-1"
  }
}

resource "aws_nat_gateway" "Test-Nat-gateway-2" {
allocation_id = aws_eip.Test-eip.id
subnet_id = aws_subnet.Test-priv-sub2.id

tags = {
    Name = "Test-Nat-gateway-2"
  }
}

# create security group for the ec2 instance
resource "aws_security_group" "Test-sec-group" {
  name = "Test security group"
  description = var.Test-sec-group-aws_security_group
  vpc_id      = aws_vpc.Prod-rock-VPC.id


  ingress  {
    description       = "ssh access"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks        = ["185.49.75.149/32"]
  }

  ingress  {
    description       = "HTTP access"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks        = ["0.0.0.0/0"]
  }

  egress {
    from_port         = 0
    to_port           = 0
    protocol          = -1
    cidr_blocks        = ["0.0.0.0/0"]
}
  tags            = {
    Name          = "Test security group"

  }  
}

# creating an ec2 server
resource "aws_instance" "Test-server-1" {
  ami            = var.Test-server-1-aws_instance
  instance_type  = "t2.micro"
  subnet_id      = aws_subnet.Test-public-sub1.id
  tenancy        = "default"

  tags           = {
    Name         = "Test-server-1"
  }
}

resource "aws_instance" "Test-server-2" {
  ami            = var.Test-server-2-aws_instance
  instance_type  = "t2.micro"
  subnet_id      = aws_subnet.Test-priv-sub1.id
  tenancy        = "default"

  tags           = {
    Name         = "Test-server-2"
  }
}