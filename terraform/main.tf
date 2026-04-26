module "network" {
  source = "./modules/network"

  subnets = var.subnets
  vpc_config = var.vpc_config
}

module "ecr" {
  source = "./modules/ecr"
}

module "ec2" {
  source = "./modules/ec2"

  subnet_ids            = module.network.server_subnets
  ecr_repo_url          = module.ecr.repository_url
  instance_count        = var.instance_count
  key_name              = var.key_name
  instance_type         = var.instance_type
  instance_profile_name = module.ecr.instance_profile_name

  ec2_ingress_rules = var.ec2_ingress_rules

  alb_ingress_rules = var.alb_ingress_rules
}

module "alb" {
  source = "./modules/alb"

  subnet_ids   = module.network.public_subnets
  vpc_id       = module.network.vpc_id
  instance_ids = module.ec2.instance_ids
}