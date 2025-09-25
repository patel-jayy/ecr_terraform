provider "aws" {
  region  = "eu-west-1"
  profile = "personal"
}

# ---------------------------
# VPC Module
# ---------------------------
module "vpc_setup" {
  source = "./modules/vpc"
}

# ---------------------------
# ECS Module
# ---------------------------
module "ecs_setup" {
  source          = "./modules/ecs"
  vpc_id          = module.vpc_setup.vpc_id
  private_subnets = module.vpc_setup.private_subnets
  public_subnets  = module.vpc_setup.public_subnets
}

# ---------------------------
# RDS Module
# ---------------------------
module "rds_setup" {
  source          = "./modules/rds"
  vpc_id          = module.vpc_setup.vpc_id
  private_subnets = module.vpc_setup.private_subnets
  ecs_sg_id       = module.ecs_setup.ecs_sg_id
}
