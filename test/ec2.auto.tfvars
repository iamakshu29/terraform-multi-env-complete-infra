ec2 = {
  ami           = "ami-0150ccaf51ab55a51"
  instance_type = "t2.micro"
  key_name      = "terraform"
  tags = {
    Name = "HelloWorld"
  }

  #   allow_tls_ipv4 = {
  #     cidr_ipv4 = "0.0.0.0"
  #   }

  #   allow_ssh_ipv4 = {
  #     cidr_ipv4 = "0.0.0.0"
  #   }
}

