# Global
aws_region  = "us-west-2"
name_prefix = "eks-modular"
tags = {
  Project     = "eks-modular"
  Environment = "dev"
  Owner       = "team"
}

# EKS
cluster_name        = "karan-private-eks-cluster"
cluster_version     = "1.28"
enable_public_endpoint = false
node_group_name        = "default-ng"

# VPC and subnets
vpc_cidr = "10.10.0.0/16"

public_subnets_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24",
]

private_subnets_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24",
]

# Leave empty list to auto-pick AZs based on the region
availability_zones = []

# Node group sizing and instance types
node_group_instance_types = ["t3.medium"]
node_group_desired        = 2
node_group_min            = 1
node_group_max            = 3

# Security Group settings
nodes_sg_name        = "eks-nodes-sg"
nodes_sg_description = "Security group for EKS worker nodes"

# IAM role names and attached policies
cluster_role_name = "eksClusterRole"
cluster_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
]

node_role_name = "eksNodegroupRole"
node_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
]

# VPC Endpoint
s3_endpoint_name = "s3-gateway-endpoint"
