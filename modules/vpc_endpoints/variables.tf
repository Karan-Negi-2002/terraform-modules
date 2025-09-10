variable "cluster_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "route_table_public_id" {
  type = string
}

variable "route_table_private_id" {
  type = string
}

variable "interface_endpoints" {
  type    = list(string)
  default = ["ecr.api", "ecr.dkr", "sts", "logs", "ec2"]
}
