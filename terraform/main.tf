# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source   = "./modules/vpc"
  name     = var.name
  vpc_cidr = var.vpc_cidr
  azs      = var.azs
}

# -----------------------------
# RDS Module
# -----------------------------
module "rds" {
  source   = "./modules/rds"

  db_name  = var.db_name
  username = var.db_username
  subnets  = module.vpc.private_subnets
  sg_ids   = [module.vpc.rds_sg_id]
}

# -----------------------------
# S3 Module
# -----------------------------
module "s3" {
  source = "./modules/s3"
  name   = var.name
}

# -----------------------------
# Classic ELB Module
# -----------------------------
module "elb" {
  source       = "./modules/elb"
  name         = var.name
  vpc_id       = module.vpc.vpc_id
  subnets      = module.vpc.public_subnets
  elb_sg_id    = module.vpc.elb_sg_id
  target_sg_id = module.vpc.ec2_sg_id
}

# -----------------------------
# EC2 Module
# -----------------------------
module "ec2" {
  source        = "./modules/ec2"
  name          = var.name
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnets       = module.vpc.public_subnets
  desired_capacity = 2
  max_size        = 3
  min_size        = 1

  ec2_sg_id       = module.vpc.ec2_sg_id
  elb_name        = module.elb.name

  # Pass RDS and S3 info
  db_endpoint     = module.rds.db_endpoint
  db_password     = module.rds.db_password
  s3_bucket_name  = module.s3.bucket_name
}
