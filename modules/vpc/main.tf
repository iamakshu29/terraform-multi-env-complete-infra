# VPC 
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags
}

# Subnet
resource "aws_subnet" "main" {
  for_each          = var.subnet

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = each.value.tags
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.main.id
  tags     = var.internet_gateway.tags
}

# Elastic IP
resource "aws_eip" "lb" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.main["test_2"].id
  tags = var.nat_gateway.tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = var.route_table.cidr_block

    # for Internet Gateway
    gateway_id = aws_internet_gateway.igw.id

    # for local ie private connection
    # gateway_id = local
    # for NAT Gateway
    # nat_gateway_id = aws_nat_gateway.ngw.id
    # can be more
    # vpc_endpoint_id = 
    # transit_gateway_id =  
    # vpc_peering_connection_id =  
  }

  tags = var.route_table.tags
}

# ✅ 4. Route table — static vs dynamic routing

# Your route block is hardcoded to use an Internet Gateway:

# route {
#   cidr_block = var.route_table.cidr_block
#   gateway_id = aws_internet_gateway.igw.id
# }


# But sometimes you might want to use a NAT Gateway (for private subnets), or VPC peering, or others.

# Solution: Use conditional logic in your route block:

# route {
#   cidr_block = var.route_table.cidr_block

#   gateway_id     = var.use_igw ? aws_internet_gateway.igw.id : null
#   nat_gateway_id = var.use_nat ? aws_nat_gateway.ngw.id : null
#   # peering, transit gateway, etc. can be added similarly
# }


# Then pass booleans from .tfvars:

# use_igw = true
# use_nat = false


# Terraform will ignore nulls.

# VPC Peering Resource
resource "aws_vpc_peering_connection" "foo" {

  # ID of VPC with which you are requesting to connected
  peer_vpc_id = "vpc-23424"

  # Id of requester VPC
  vpc_id = aws_vpc.main.id

  # Accepting connection by both VPCs
  auto_accept = true

  tags = var.vpc_peering.tags
}
