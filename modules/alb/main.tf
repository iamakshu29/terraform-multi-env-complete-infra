# ALB
resource "aws_lb" "test" {
  name            = var.alb.alb_test.name
  internal        = try(var.alb.alb_test.internal,false)
  security_groups = [aws_security_group.lb_sg.id]
  subnets         = var.subnets # expects a list
  # enable_deletion_protection = true

  tags = var.alb.alb_test.tags
}

# ALB Target Group
resource "aws_lb_target_group" "tcp-example" {
  name     = var.alb.alb_tg.name
  port     = try(var.alb.alb_tg.port,80)
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    path                = "/"        # your app endpoint
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn

  # If adding SSL certi, then change the port and protocol to 443 and HTTPS, respectively
  port     = "80"
  protocol = "HTTP"


  #  SSL certi for HTTPS
  # ssl_policy = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tcp-example.arn
  }
}

# ALB Security Group
resource "aws_security_group" "lb_sg" {
  name        = "alb-sg"
  description = "allow port 80 and 22"
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_lb" {
  security_group_id = aws_security_group.lb_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
