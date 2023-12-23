variable "aws_region" {
  description = "AWS Region"
}

variable "create_vpc" {
  description = "Create VPC"
  type        = bool
  default     = true
}

variable "instance_subnet_id" {
  description = "Instance Subnet ID"
  default     = ""
}

variable "vpc_data" {
  description = "VPC Data"
  type = object({
    name               = string
    cidr_block         = string
    public_subnets     = list(string)
    availability_zones = list(string)
  })
  default = {
    name               = ""
    cidr_block         = ""
    public_subnets     = []
    availability_zones = []
  }
}

variable "vpc_id" {
  description = "VPC ID in case of using existing VPC"
  default     = ""
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
