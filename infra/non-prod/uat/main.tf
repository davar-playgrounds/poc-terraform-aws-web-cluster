provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
  shared_credentials_file = var.cred_path
  profile = var.cred_profile
}

variable "aws_region" {
  default = "ap-southeast-2"
}

variable "cred_path" {
  default = "/home/phiro/.aws/credentials"
}

variable "cred_profile" {
  default = "private"
}

module "core_infrastructure" {
  source = "../../../terraform/"

  vpc_name = "PoS UAT VPC"
  vpc_cidr = "10.2.0.0/21"
  private_subnets = ["10.2.0.0/24","10.2.1.0/24","10.2.2.0/24"]
  public_subnets = ["10.2.3.0/24","10.2.4.0/24","10.2.5.0/24"]
  enable_nat_gw = true
  environment = "uat"
  region = var.aws_region
  loadbalancer_name_prefix = "website-lb-uat"
  bucket_logging_name = "loadbalance-access-logging-uat"
}