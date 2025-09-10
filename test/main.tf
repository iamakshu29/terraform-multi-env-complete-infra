module "vpc" {
  source           = "../modules/vpc/"
  vpc              = var.vpc
  use_igw          = var.use_igw
  use_nat          = var.use_nat
}

module "ec2" {
  source = "../modules/ec2"
  ec2    = var.ec2
  subnet_ids = [
    module.vpc.public_subnet_1,
    module.vpc.public_subnet_2,
    module.vpc.private_subnet_1,
    module.vpc.private_subnet_2
  ]
}

module "alb" {
  source  = "../modules/alb"
  alb     = var.alb
  subnets = [module.vpc.public_subnet_1]
  vpc_id  = module.vpc.vpc_id
}

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
