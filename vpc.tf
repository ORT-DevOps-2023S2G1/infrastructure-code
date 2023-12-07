resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        name = "main"
    }
}

resource "aws_subnet" "subnet_dev" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 3)
    map_public_ip_on_launch = true
    availability_zone       = var.region
}

resource "aws_subnet" "subnet_stg" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
    map_public_ip_on_launch = true
    availability_zone       = var.region
}

resource "aws_subnet" "subnet_prd" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
    map_public_ip_on_launch = true
    availability_zone       = var.region
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "internet_gateway"
    }
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
}

resource "aws_route_table_association" "subnet_route" {
    subnet_id      = aws_subnet.subnet_dev.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
    subnet_id      = aws_subnet.subnet_stg.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
    subnet_id      = aws_subnet.subnet_prd.id
    route_table_id = aws_route_table.route_table.id
}