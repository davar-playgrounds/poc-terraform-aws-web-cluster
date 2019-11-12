variable "aws_region" {
  default = "eu-west-2"
}

variable "cred_path" {
  default = "/home/phiro/.aws/credentials"
}

variable "cred_profile" {
  default = "sandpit"
}


provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
  shared_credentials_file = var.cred_path
  profile = var.cred_profile
}


module "website" {
  source = "../../../terraform/"

  vpc_name = "PoS DEV VPC"
  vpc_cidr = "10.1.0.0/21"
  private_subnets = ["10.1.0.0/24","10.1.1.0/24","10.1.2.0/24"]
  public_subnets = ["10.1.3.0/24","10.1.4.0/24","10.1.5.0/24"]
  enable_nat_gw = true
  environment = "dev"
  region = var.aws_region
  loadbalancer_name_prefix = "website-lb-dev"
  bucket_logging_name = "phiro-lbdev"
}