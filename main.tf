terraform {
  required_version = "~> 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  create_vpc = var.create_vpc
  vpc_data   = var.vpc_data
  vpc_id     = var.vpc_id
}

locals {
  vpc_data_validation           = local.create_vpc && local.vpc_data.name != "" && local.vpc_data.cidr_block != "" && length(local.vpc_data.public_subnets) > 0 && length(local.vpc_data.availability_zones) > 0 ? true : false
  vpc_id_validation             = !local.create_vpc && local.vpc_id != "" ? true : false
  instance_subnet_id_validation = local.create_vpc ? true : var.instance_subnet_id != "" ? true : false
}

check "vpc_data_validation" {
  assert {
    condition     = (local.vpc_data_validation == true && local.vpc_id_validation == false) || (local.vpc_data_validation == false && local.vpc_id_validation == true)
    error_message = "VPC Data must be provided when creating a new VPC. If you set create_vpc to false, you must provide a VPC ID, not VPC Data. Similarly, if you set create_vpc to true, you must provide VPC Data, not a VPC ID."
  }
}

check "instance_subnet_id_validation" {
  assert {
    condition     = local.instance_subnet_id_validation == true
    error_message = "Instance Subnet ID must be provided when creating a new VPC."
  }
}