variable "vpc_name"{}
variable "vpc_cidr" {}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "enable_nat_gw" {}
variable "environment" {}
variable "region" {}
variable "loadbalancer_name_prefix" {}
variable "bucket_logging_name" {}
variable "deploy_image_website" {}
variable "deploy_image_website_instance_type" {}
variable "number_of_instances" {
  default = 3
  description = "Number of instances running"
}
variable "minumum_number_of_instances" {
  default = 3
  description = "Needs to be smaller than the number_of_instances"
}

variable "maximum_number_of_instances" {
  default = 6
  description = "Needs to be larger than the number_of_instances"
}

variable "release_version" {
  default = "0.0.0"
}