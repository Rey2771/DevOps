locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

module "network" {
  source = "./modules/network"

  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_count = var.public_subnet_count
}

module "web_server" {
  source = "./modules/web-server"

  name_prefix        = local.name_prefix
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  subnet_id          = module.network.public_subnet_ids[0]
  instance_type      = var.instance_type
  allowed_http_cidrs = var.allowed_http_cidrs
}