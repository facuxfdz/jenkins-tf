module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name           = var.vpc_name
  cidr           = var.cidr_block
  azs            = var.availability_zones
  public_subnets = var.public_subnets
}