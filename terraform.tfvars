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

# Advanced EKS endpoint controls and logging
endpoint_private_access = true
endpoint_public_access  = false
public_access_cidrs     = []

enabled_cluster_log_types = [
  "api",
  "audit",
  "authenticator",
]

# Node group image/SSH options
ami_type  = "AL2_x86_64"
ec2_ssh_key = ""    # Set to your key pair name to enable SSH, else leave empty
node_ssh_source_security_group_ids = []  # e.g., ["sg-xxxxxxxx"] when SSH enabled

# Security Group tuning (control-plane to nodes on 443)
ingress_cp_cidr_blocks = [
  "10.10.0.0/16",
]

# Interface VPC Endpoints (optional)
interface_endpoints = [
  "ecr.api",
  "ecr.dkr",
  "sts",
  "logs",
  "ec2",
]
interface_vpc_endpoint_type = "Interface"
private_dns_enabled         = true
endpoints_sg_name           = "vpc-endpoints-sg"
endpoints_sg_description    = "Security group for VPC Interface Endpoints"
