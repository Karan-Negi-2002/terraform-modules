variable "vpc_id" {
  type        = string
  description = "VPC ID where SGs will be created"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for intra-vpc rules"
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "nodes_sg_name" {
  description = "Name for EKS nodes security group"
  type        = string
}

variable "nodes_sg_description" {
  description = "Description for EKS nodes security group"
  type        = string
}
