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