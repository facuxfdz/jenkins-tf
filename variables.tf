variable "aws_region" {
  description = "AWS Region"
}

variable "vpc_name" {
  description = "VPC Name"  
}

variable "cidr_block" {
  description = "CIDR Block"
}

variable "public_subnets" {
  description = "Public Subnets"
}

variable "availability_zones" {
  description = "Availability Zones for vpc"
}

variable "public_key_path" {
  description = "Public Key Path"
}

variable "jenkins_admin_credentials" {
  description = "Jenkins Credentials"
  type = object({
    username = string
    password = string
  })
}

variable "jenkins_plugins" {
  description = "Jenkins Plugins"
  type        = string
}