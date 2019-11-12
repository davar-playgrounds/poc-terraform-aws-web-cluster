module "loadbalancer_website" {

  source  = "telia-oss/loadbalancer/aws"
  version = "3.0.0"

  name_prefix = var.loadbalancer_name_prefix
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets
  type        = "application"


  tags = {
    environment = "dev"
    terraform   = "True"
  }
}