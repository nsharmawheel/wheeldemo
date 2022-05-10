resource "aws_eip" "nat_eip" {
    vpc = true
    tags = {
        Name = "nat_eip"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_1.id
    tags = {
        Name = "nat_gw"
    }
}


resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.demo_vpc.id
    tags = {
        Name = "demo_private_rt"
    }
}

resource "aws_route_table_association" "private_rt1" {
    subnet_id = aws_subnet.private_1.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt2" {
    subnet_id = aws_subnet.private_2.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt3" {
    subnet_id = aws_subnet.private_3.id
    route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "public_nat_route" {
    route_table_id = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
}

