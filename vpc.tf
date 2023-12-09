
resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        name = "vpc-main"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "internet_gateway"
    }
}

resource "aws_subnet" "subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id
}

resource "aws_route" "vpc-dev-public-route" {
    route_table_id         = aws_route_table.route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "subnet_route" {
    route_table_id = aws_route_table.route_table.id
    subnet_id      = aws_subnet.subnet.id

}

resource "aws_route_table_association" "subnet_route2" {
    route_table_id = aws_route_table.route_table.id
    subnet_id      = aws_subnet.subnet2.id
}


