env = "test"
use_igw = true
use_nat = false

vpc = {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

subnet = {
  test_1 = {
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "test-subnet-1"
      Type = "test-public-1"
      Public = "true"
    }
  },
  test_2 = {
    cidr_block        = "10.1.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "test-subnet-2"
      Type = "test-public-2"
      Public = "true"
    }
  },
  test_3 = {
    cidr_block        = "10.1.3.0/24"
    availability_zone = "us-east-1c"
    tags = {
      Name = "test-subnet-3"
      Type = "test-private-1"
      Public = "false"
    }
  },
  test_4 = {
    cidr_block        = "10.1.4.0/24"
    availability_zone = "us-east-1d"
    tags = {
      Name = "test-subnet-4"
      Type = "test-private-2"
      Public = "false"
    }
  }
}

internet_gateway = {
  tags = {
    Name = "test-igw"
  }
}

nat_gateway = {
  subnet_id = "10.1.2.0/24"
  tags = {
    Name = "test-natGW"
  }
}

route_table = {
  cidr_block = "0.0.0.0/0"
  tags = {
    Name = "test-route-table"
  }
}

vpc_peering = {
  tags = {
    Name = "test-vpc-peering"
  }
}
