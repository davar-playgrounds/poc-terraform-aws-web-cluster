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

variable "deploy_image_website" {}

variable "release_version" {
  default = "0.0.3"
}


module "core_infrastructure" {
  source = "../../../terraform-module/"

  vpc_name = "PoS UAT VPC"
  vpc_cidr = "10.2.0.0/21"
  private_subnets = ["10.2.0.0/24","10.2.1.0/24","10.2.2.0/24"]
  public_subnets = ["10.2.3.0/24","10.2.4.0/24","10.2.5.0/24"]
  enable_nat_gw = true
  environment = "uat"
  region = var.aws_region
  loadbalancer_name_prefix = "website-lb-uat"
  bucket_logging_name = "loadbalance-access-logging-uat"
  deploy_image_website_instance_type = "t2.small"
  number_of_instances = 6
  maximum_number_of_instances = 6
  minumum_number_of_instances = 3
  deploy_image_website = var.deploy_image_website
  release_version= var.release_version

}

output "loadbalancer_dns" {
  value = module.core_infrastructure.loadbalancer_entry_point
}