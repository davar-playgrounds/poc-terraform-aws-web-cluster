provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
  shared_credentials_file = var.cred_path
  profile = var.cred_profile
}

variable "aws_region" {
  default = "us-west-1"
}

variable "cred_path" {
  default = "/home/phiro/.aws/credentials"
}

variable "cred_profile" {
  default = "sandpit"
}
module "website" {
  source = "../../../terraform/"

  vpc_name = "PoS PROD VPC"
  vpc_cidr = "10.3.0.0/22"
  private_subnets = ["10.3.0.0/24","10.3.1.0/24","10.3.2.0/24"]
  public_subnets = ["10.3.3.0/24","10.3.4.0/24","10.3.5.0/24"]
  enable_nat_gw = true
  environment = "dev"
  region = var.aws_region
}