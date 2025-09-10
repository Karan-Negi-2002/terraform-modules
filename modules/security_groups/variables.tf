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

variable "ingress_cp_cidr_blocks" {
  description = "List of CIDR blocks allowed to access nodes on control-plane ports (443)"
  type        = list(string)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks for nodes SG egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
