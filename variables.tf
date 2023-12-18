variable "aws_region" {
    description = "AWS Region"
    default = "us-east-1"
}

variable "vpc_name" {
    description = "VPC Name"
    default = "jenkins-vpc"
}

variable "cidr_block" {
    description = "CIDR Block"
    default = "10.0.0.0/22"
}

variable "public_subnets" {
    description = "Public Subnets"
    default = ["10.0.1.0/24"]
}

variable "availability_zones" {
    description = "Availability Zones for vpc"
    default = ["us-east-1a"]
}

variable "private_key_path" {
    description = "Private Key Path"
    default = "~/.ssh/id_rsa"
}

variable "public_key_path" {
    description = "Public Key Path"
    default = "~/.ssh/id_rsa.pub"
}