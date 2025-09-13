resource "aws_instance" "main" {
  ami                    = var.ec2.ami
  instance_type          = var.ec2.instance_type
  key_name               = var.ec2.key_name
  subnet_id              = var.subnet_id[0] # output from vpc module
  vpc_security_group_ids = [aws_security_group.main.id]
  tags                   = var.ec2.tags
}

resource "aws_security_group" "main" {
  name        = "main-sg"
  description = "allow port 80 and 22"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.main.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
