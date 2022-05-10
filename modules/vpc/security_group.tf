#group for access to elb over the internet
resource "aws_security_group" "demo-elb-sg" {
  name        = "demo-elb-sg"
  description = "only do 80 and 443"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "only-webtraffic"
  }
}

#group for access to k8s services and pods etc.
resource "aws_security_group" "demo-cluster-sg" {
  name        = "demo-cluster-sg"
  description = "all traffic internal"
  vpc_id      = aws_vpc.demo_vpc.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "internal-only"
  }
}

output "demo-cluster-sg" {
 value = aws_security_group.demo-cluster-sg.id
}

output "demo-elb-sg" {
 value = aws_security_group.demo-elb-sg.id
}
