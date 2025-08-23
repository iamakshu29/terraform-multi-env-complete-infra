vpc = {
  test = {
    cidr_block = "10.1.0.0/16"
    tags = {
      Name = "test-vpc"
    }
  },
  dev = {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev-vpc"
    }
  },
  prod = {
    cidr_block = "10.2.0.0/16"
    tags = {
      Name = "prod-vpc"
    }
  }
}

subnet = {
  test-1 = {
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
      Name = "test-subnet-1"
      Type = "test-public-1"
    }
  },
  test-2 = {
    cidr_block        = "10.1.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "test-subnet-2"
      Type = "test-public-2"
    }
  },
  test-3 = {
    cidr_block        = "10.1.3.0/24"
    availability_zone = "us-east-1c"
    tags = {
      Name = "test-subnet-3"
      Type = "test-private-1"
    }
  },
  test-4 = {
    cidr_block        = "10.1.4.0/24"
    availability_zone = "us-east-1d"
    tags = {
      Name = "test-subnet-4"
      Type = "test-private-2"
    }
  },
  dev-1 = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1a"
    tags = {
      Name = "dev-subnet-1"
      Type = "dev-public-1"
    }
  },
  dev-2 = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-west-1b"
    tags = {
      Name = "dev-subnet-2"
      Type = "dev-public-2"
    }
  },
  dev-3 = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-west-1c"
    tags = {
      Name = "dev-subnet-3"
      Type = "dev-private-1"
    }
  },
  dev-4 = {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-west-1d"
    tags = {
      Name = "dev-subnet-4"
      Type = "dev-private-2"
    }
  },
  prod-1 = {
    cidr_block        = "10.2.1.0/24"
    availability_zone = "eu-west-1a"
    tags = {
      Name = "prod-subnet-1"
      Type = "prod-public-1"
    }
  },
  prod-2 = {
    cidr_block        = "10.2.2.0/24"
    availability_zone = "eu-west-1b"
    tags = {
      Name = "prod-subnet-2"
      Type = "prod-public-2"
    }
  },
  prod-3 = {
    cidr_block        = "10.2.3.0/24"
    availability_zone = "eu-west-1c"
    tags = {
      Name = "prod-subnet-3"
      Type = "prod-private-1"
    }
  },
  prod-4 = {
    cidr_block        = "10.2.4.0/24"
    availability_zone = "eu-west-1d"
    tags = {
      Name = "prod-subnet-4"
      Type = "prod-private-2"
    }
  }
}

igw = {
  test = {
    tags = {
      Name = "test-igw"
    }
  },
  dev = {
    tags = {
      Name = "dev-igw"
    }
  },
  prd = {
    tags = {
      Name = "prod-igw"
    }
  }
}

nat-gateway = {
  test = {
    allocation_id = ""
    subnet_id     = "10.1.2.0/24"
  },
  dev = {
    allocation_id = ""
    subnet_id     = "10.0.2.0/24"
  },
  prod = {
    allocation_id = ""
    subnet_id     = ""
  }
}

vpc-peering = {
  peer_vpc_id = ""
  vpc_id      = "10.2.2.0/24"
}

route-table = {
  test = {
    cidr_block = "10.1.0.0/16"

    tags = {
      Name = "test-reoute-table"
    }
  },
  dev = {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "dev-route-table"
    }
  },
  prod = {
    cidr_block = "10.2.0.0/16"
    tags = {
      Name = "prod-route-table"
    }
  }
}
