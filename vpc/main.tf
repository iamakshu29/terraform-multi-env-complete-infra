# VPC 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main"
  }
}

# Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Main"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Elastic IP
resource "aws_eip" "lb" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.main.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.1.0/24"

    # for Internet Gateway
    gateway_id = aws_internet_gateway.gw.id

    # for local ie private connection
    # gateway_id = local
    # for NAT Gateway
    # nat_gateway_id = aws_nat_gateway.ngw.id
    # can be more
    # vpc_endpoint_id = 
    # transit_gateway_id =  
    # vpc_peering_connection_id =  
  }

  tags = {
    Name = "example"
  }

}

# VPC Peering Resource
resource "aws_vpc_peering_connection" "foo" {
  # ID of VPC with which you are requesting to connected
  peer_vpc_id = aws_vpc.bar.id

  # Id of requester VPC
  vpc_id = aws_vpc.foo.id

  # Accepting connection by both VPCs
  auto_accept = true

  tags = {
    Name = "VPC Peering between foo and bar"
  }
}
