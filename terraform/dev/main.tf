provider "aws" {
  region  = "us-west-1"
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket         = "nency-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-west-1"
    dynamodb_table = "nency_terraform_lock-table"
    #profile        = "prod"
    encrypt = true
  }
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  instance_count    = 2
  public_subnet_ids = module.vpc.public_subnet_ids
  key_name          = "nency"
  security_group_id = module.security_group.sg_id
}

module "rds" {
  source             = "./modules/rds"
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

