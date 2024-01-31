resource "aws_vpc" "lab_ecs_vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "lab_ecs_vpc_${var.env}"
    Environment = var.env
  }
}
#   #   # AWS_SUBNETS_PUBLIC #  #   #
resource "aws_subnet" "sub_pub_1" {
  vpc_id            = aws_vpc.lab_ecs_vpc.id
  cidr_block        = var.subnet_public[0]
  availability_zone = "${var.region}a"
  tags = {
    Name = "sub_pub_1_${var.env}"
  }
}
resource "aws_subnet" "sub_pub_2" {
  vpc_id            = aws_vpc.lab_ecs_vpc.id
  cidr_block        = var.subnet_public[1]
  availability_zone = "${var.region}b"
  tags = {
    Name = "sub_pub_2_${var.env}"
  }
}

#   #   # AWS INTERNET GATEWAY #  #   #
resource "aws_internet_gateway" "lab_ecs_ig" {
  vpc_id = aws_vpc.lab_ecs_vpc.id
  tags = {
    Name = "lab_ecs_ig_${var.env}"
  }
}
#   #   # AWS ROUTE TABLE #  #   #
resource "aws_route_table" "lab_ecs_rt" {
  vpc_id = aws_vpc.lab_ecs_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_ecs_ig.id
  }
  tags = {
    Name = "lab_ecs_rt_${var.env}"
  }
}
#   #   # AWS ROUTE TABLE ASSOCIATION  #  #   #
resource "aws_route_table_association" "lab_ecs_art" {
  subnet_id      = aws_subnet.sub_pub_1.id
  route_table_id = aws_route_table.lab_ecs_rt.id
}
#   #   # AWS ROUTE TABLE ASSOCIATION  #  #   #
resource "aws_route_table_association" "lab_ecs_art2" {
  subnet_id      = aws_subnet.sub_pub_2.id
  route_table_id = aws_route_table.lab_ecs_rt.id
}
#   #   # AWS SECURITY GROUP #  #   #
resource "aws_security_group" "lab_ecs_sg" {
  name        = "lab_ecs_sg"
  description = "lab_ecs_sg"
  vpc_id      = aws_vpc.lab_ecs_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip}"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "lab_ecs_sg_${var.env}"
  }
}