module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.18.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Purpose = "PoS"
    State = "Experimental"
    Owner = "Philip Rodrigues"
    Owner_team = "CloudOps"
    Expire_by = "20191231"
    Environment = var.environment
  }
}

