module "vpc" {
  source = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  aws_region          = var.aws_region
  project_name        = var.project_name
}

module "load_balancers" {
  source = "./modules/load-balancers"
  
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  project_name       = var.project_name
}

module "proxy" {
  source = "./modules/proxy"
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id             = module.vpc.vpc_id
  proxy_sg_id        = module.load_balancers.proxy_sg_id
  project_name       = var.project_name
  instance_count     = 2
  key_name          = var.key_name
  proxy_target_group_arn = module.load_balancers.proxy_target_group_arn
}

module "backend_app" {
  source = "./modules/backend-app"
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  backend_sg_id      = module.load_balancers.backend_sg_id
  project_name       = var.project_name
  instance_count     = 2
  key_name          = var.key_name
  internal_alb_dns  = module.load_balancers.internal_alb_dns
  backend_target_group_arn  = module.load_balancers.backend_target_group_arn
  }

resource "local_file" "ips_file" {
  filename = "all-ips.txt"
  content = <<EOT
public-ip1 ${module.proxy.proxy_public_ips[0]}
public-ip2 ${module.proxy.proxy_public_ips[1]}
private-ip1 ${module.backend_app.backend_private_ips[0]}
private-ip2 ${module.backend_app.backend_private_ips[1]}
alb-public-dns ${module.load_balancers.public_alb_dns}
alb-internal-dns ${module.load_balancers.internal_alb_dns}
EOT
}