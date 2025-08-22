module "vpc" {
  source = "../vpc/"
  vpc = var.vpc
}

module "ec2" {
  source = "../ec2/"
  ec2 = var.ec2
}

module "alb" {
  source = "../alb/"
  alb = var.alb
}

module "asg" {
  source = "../asg/"
  asg = var.asg
}

module "rds" {
  source = "../rds/"
  rds = var.rds
}

module "s3" {
  source = "../s3/"
  s3 = var.s3
}

module "kms" {
  source = "../kms/"
  kms = var.kms
}