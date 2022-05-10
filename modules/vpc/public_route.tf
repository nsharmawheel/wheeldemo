resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.demo_vpc.id
    tags = {
        Name = "eks_igw"
    }
}
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.demo_vpc.id
    tags = {
        Name = "demo_public_rt"
    }
}

resource "aws_route" "public_igw_route" {
    route_table_id = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}


resource "aws_route_table_association" "public_rt1" {
    subnet_id = aws_subnet.public_1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt2" {
    subnet_id = aws_subnet.public_2.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt3" {
    subnet_id = aws_subnet.public_3.id
    route_table_id = aws_route_table.public_rt.id
}
