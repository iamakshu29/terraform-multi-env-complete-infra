# VPC 
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc.test_vpc.cidr_block
  tags       = var.vpc.test_vpc.tags
}

# Subnet
resource "aws_subnet" "main" {
  for_each = var.vpc.subnet

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  # will check if Public key in tags is "True" then it will map a public ip which will create a public subnet, else false -> private subnet
  map_public_ip_on_launch = lookup(each.value.tags, "Public", "false") == "true"

  tags = each.value.tags
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = var.vpc.internet_gateway.tags
}

# Elastic IP
resource "aws_eip" "lb" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.main["test_2"].id
  tags          = var.vpc.nat_gateway.tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  # you can define multiple routes
  # route {

  # }
  # route {
  #   cidr_block = var.route_table.cidr_block

  #   # Using conditional logic in your route block:
  #   # for Internet Gateway
  #   gateway_id = var.use_igw ? aws_internet_gateway.igw.id : null

  #   # for NAT Gateway
  #   nat_gateway_id = var.use_nat ? aws_nat_gateway.ngw.id : null

  #   # for local ie private connection
  #   # gateway_id = local
  #   # can be more
  #   # vpc_endpoint_id = 
  #   # transit_gateway_id =  
  #   # vpc_peering_connection_id =  
  # }

  tags = var.vpc.route_table.tags
}

# you can also create aws_route resource separately instead of route{} block
# below route is to connect igw to internet
resource "aws_route" "default_route" {
  route_table_id = aws_route_table.rt.id 
  destination_cidr_block = "0.0.0.0/0" 
  gateway_id = aws_internet_gateway.igw.id
}


# To bridge the gap between subnet and route_table we use route_table_association
# they are subnet association, the feature in which we explicitly pull the subnet from the default route table where all the subnet are present implcitly
resource "aws_route_table_association" "rt_association" {
  # region = "us-east-1"
  subnet_id = aws_subnet.main["test_2"].id
  # OR
  # gateway_id = aws_nat_gateway.ngw.id
  route_table_id = aws_route_table.rt.id
}


# VPC Peering Resource
resource "aws_vpc_peering_connection" "foo" {

  # ID of VPC with which you are requesting to connected
  peer_vpc_id = "vpc-23424"

  # Id of requester VPC
  vpc_id = aws_vpc.main.id

  # Accepting connection by both VPCs
  auto_accept = true

  tags = var.vpc.vpc_peering.tags
}
