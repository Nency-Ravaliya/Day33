resource "aws_vpc" "nency_vpc" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "nency-main-vpc"
  }
}

resource "aws_subnet" "nency_public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.nency_vpc.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "nency-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "nency_private" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.nency_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "nency-private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "nency_igw" {
  vpc_id = aws_vpc.nency_vpc.id
  tags = {
    Name = "nency-main-igw"
  }
}

resource "aws_route_table" "nency_public" {
  vpc_id = aws_vpc.nency_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nency_igw.id
  }
  tags = {
    Name = "nency-public-route-table"
  }
}

resource "aws_route_table_association" "nency_public" {
  count = length(aws_subnet.nency_public)
  subnet_id = element(aws_subnet.nency_public.*.id, count.index)
  route_table_id = aws_route_table.nency_public.id
}

