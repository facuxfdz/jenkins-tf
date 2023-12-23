module "vpc" {
  count  = var.create_vpc ? 1 : 0
  source = "terraform-aws-modules/vpc/aws"

  name           = var.vpc_data.name
  cidr           = var.vpc_data.cidr_block
  azs            = var.vpc_data.availability_zones
  public_subnets = var.vpc_data.public_subnets
}