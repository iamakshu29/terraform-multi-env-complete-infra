module "vpc" {
  source  = "../modules/vpc/"
  vpc     = var.vpc
  use_igw = var.use_igw
  use_nat = var.use_nat
}

module "ec2" {
  source = "../modules/ec2"
  ec2    = var.ec2
  vpc_id      = module.vpc.vpc_id

  # variable created, when need to use the output of another module
  subnet_id = [
    module.vpc.public_subnet_1
  ]
}

module "asg_sg" {
  source = "../modules/SecurityGroup"
  vpc_id      = module.vpc.vpc_id
}

module "alb" {
  source = "../modules/alb"
  alb    = var.alb
  subnets = [
    module.vpc.public_subnet_1,
    module.vpc.public_subnet_2
  ]
  vpc_id = module.vpc.vpc_id # expects string here
}

module "asg" {
  source      = "../modules/asg"
  asg         = var.asg
  subnets     = [module.vpc.public_subnet_1]
  asg_sg_id      = [module.asg_sg.sg_id] # expect list here
  aws_alb_arn = [module.alb.aws_alb_target_group_arn]
}

# module "kms" {
#   source = "../modules/kms"
#   kms    = var.kms
# }

# module "rds" {
#   source = "../modules/rds"
#   rds    = var.rds
#   subnet_ids = [
#     module.vpc.private_subnet_1,
#     module.vpc.private_subnet_2
#   ]
#   kms_key_id = module.kms.kms_key_id
# }

# module "s3" {
#   source = "../modules/s3"
#   s3     = var.s3
# }