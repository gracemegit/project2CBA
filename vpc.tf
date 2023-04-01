locals {
  public_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  #private_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
}

resource "aws_vpc" "demo_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "demo_vpc"
  }
}

resource "aws_subnet" "public1" {

  cidr_block              = local.public_cidr_blocks[0]
  vpc_id                  = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.azs[0]

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {

  cidr_block              = local.public_cidr_blocks[1]
  vpc_id                  = aws_vpc.demo_vpc.id
  map_public_ip_on_launch = true

  availability_zone = var.azs[1]

  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo_igw.id
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}



resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.demo_vpc.id

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # Outbound Rules
  # Internet access to anywhere

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-SG"
  }
}

