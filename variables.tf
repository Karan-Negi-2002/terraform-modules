variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidrs" {
  type = list(string)
}

variable "private_subnets_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "node_group_instance_types" {
  type = list(string)
}

variable "node_group_desired" {
  type = number
}

variable "node_group_min" {
  type = number
}

variable "node_group_max" {
  type = number
}

variable "cluster_version" {
  type = string
}

# New variables to avoid hardcoded values anywhere
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Prefix used for naming resources"
  type        = string
}

# Security Groups module variables
variable "nodes_sg_name" {
  description = "Name for EKS nodes security group"
  type        = string
}

variable "nodes_sg_description" {
  description = "Description for EKS nodes security group"
  type        = string
}

# IAM module variables
variable "cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  type        = string
}

variable "cluster_role_policy_arns" {
  description = "List of policy ARNs to attach to the cluster role"
  type        = list(string)
}

variable "node_role_name" {
  description = "Name of the EKS nodegroup IAM role"
  type        = string
}

variable "node_role_policy_arns" {
  description = "List of policy ARNs to attach to the node role"
  type        = list(string)
}

# EKS module variables
variable "node_group_name" {
  description = "Name for the EKS managed node group"
  type        = string
}

variable "enable_public_endpoint" {
  description = "Whether to enable public endpoint for EKS control plane"
  type        = bool
}

# VPC Endpoints module variables
variable "s3_endpoint_name" {
  description = "Name tag for S3 VPC endpoint"
  type        = string
}
