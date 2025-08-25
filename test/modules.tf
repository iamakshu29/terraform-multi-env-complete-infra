module "vpc" {
  source = "../modules/vpc/"
  # for_each = local.region_providers
  # providers = {
  #   aws = each.value
  # }
  vpc              = var.vpc
  subnet           = var.subnet
  internet_gateway = var.internet_gateway
  vpc_peering      = var.vpc_peering
  nat_gateway      = var.nat_gateway
  route_table      = var.route_table
}

# module "ec2" {
#   source = "../modules/ec2"
#   ec2    = var.ec2
# }

# module "alb" {
#   source = "../modules/alb"
#   alb    = var.alb
# }

# module "asg" {
#   source = "../modules/asg"
#   asg    = var.asg
# }

# module "rds" {
#   source = "../modules/rds"
#   rds    = var.rds
# }

# module "s3" {
#   source = "../modules/s3"
#   s3     = var.s3
# }

# module "kms" {
#   source = "../modules/kms"
#   kms    = var.kms
# }
