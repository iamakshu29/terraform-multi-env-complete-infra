module "vpc" {
  source = "../modules/vpc"
  vpc = var.vpc
}

module "ec2" {
  source = "../modules/ec2"
  ec2 = var.ec2
}

module "alb" {
  source = "../modules/alb"
  alb = var.alb
}

module "asg" {
  source = "../modules/asg"
  asg = var.asg
}

module "rds" {
  source = "../modules/rds"
  rds = var.rds
}

module "s3" {
  source = "../modules/s3"
  s3 = var.s3
}

module "kms" {
  source = "../modules/kms"
  kms = var.kms
}