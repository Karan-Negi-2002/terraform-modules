# Override variables here. These values feed into root variables.tf and then into modules.

aws_region = "us-west-2"

cluster_name = "karan-private-eks-cluster"

vpc_cidr = "10.10.0.0/16"

public_subnets_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24",
]

private_subnets_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24",
]

# Leave empty to auto-detect first 2 AZs in the region
availability_zones = []

node_group_instance_types = ["t2.medium"]

node_group_desired = 2
node_group_min     = 1
node_group_max     = 3

cluster_version = "1.28"
