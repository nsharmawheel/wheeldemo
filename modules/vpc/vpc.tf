#private subnets required for Fargate pools
#public subnets required for internet-addressable load balancer
#public tags required for kubernetes alb deployment reconciliation

variable "cluster_name" {}

resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
        Name = "eks_vpc"
    }
}

resource "aws_subnet" "private_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    "zone" = "2a"
    "accessibility" = "private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"

  tags = {
    "zone" = "2b"
    "accessibility" = "private"
  }
}

resource "aws_subnet" "private_3" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2c"

  tags = {
    "zone" = "2c"
    "accessibility" = "private"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    "zone" = "2a"
    "accessibility" = "public"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "zone" = "2b"
    "accessibility" = "public"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_3" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.13.0/24"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    "zone" = "2c"
    "accessibility" = "public"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

output "demo-vpc-id" {
 value = aws_vpc.demo_vpc.id
}

output "public-1-id" {
 value = aws_subnet.public_1.id
}

output "public-2-id" {
 value = aws_subnet.public_2.id
}

output "public-3-id" {
 value = aws_subnet.public_3.id
}

output "private-1-id" {
 value = aws_subnet.private_1.id
}

output "private-2-id" {
 value = aws_subnet.private_2.id
}

output "private-3-id" {
 value = aws_subnet.private_3.id
}
