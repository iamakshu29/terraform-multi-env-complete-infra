# VPC 
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  for_each   = var.vpc
  cidr_block = each.value.cidr_block
  tags       = each.value.tags
}

# # Subnet
# resource "aws_subnet" "main" {
#   for_each          = var.subnet
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value.cidr_block
#   availability_zone = each.value.availability_zone

#   tags = each.value.tags
# }

# # Internet Gateway
# resource "aws_internet_gateway" "igw" {
#   for_each          = var.igw
#   vpc_id = aws_vpc.main.id
#   tags = each.value.tags
# }

# # Elastic IP
# resource "aws_eip" "lb" {
#   domain = "vpc"
# }

# # NAT Gateway
# resource "aws_nat_gateway" "ngw" {
#   for_each          = var.nat-gateway
#   allocation_id = aws_eip.lb.id
#   subnet_id     = aws_subnet.main.id

#   tags = each.value.tags

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.igw]
# }

# # Route Table
# resource "aws_route_table" "rt" {
#   for_each          = var.route-table
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "10.0.1.0/24"

#     # for Internet Gateway
#     gateway_id = aws_internet_gateway.igw.id

#     # for local ie private connection
#     # gateway_id = local
#     # for NAT Gateway
#     # nat_gateway_id = aws_nat_gateway.ngw.id
#     # can be more
#     # vpc_endpoint_id = 
#     # transit_gateway_id =  
#     # vpc_peering_connection_id =  
#   }

#   tags = each.value.tags
# }

# VPC Peering Resource
# resource "aws_vpc_peering_connection" "foo" {
#   for_each          = var.vpc-peering

#   # ID of VPC with which you are requesting to connected
#   peer_vpc_id = aws_vpc.bar.id

#   # Id of requester VPC
#   vpc_id = aws_vpc.foo.id

#   # Accepting connection by both VPCs
#   auto_accept = true

#   tags = each.value.tags
# }
