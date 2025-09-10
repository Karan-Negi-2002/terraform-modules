locals {
  tags = {
    Project = var.name_prefix
  }
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones
  tags                  = var.tags
  name_prefix           = var.name_prefix
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  public_route_cidr      = var.public_route_cidr
  private_route_cidr     = var.private_route_cidr
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  vpc_cidr = var.vpc_cidr
  tags    = var.tags
  nodes_sg_name        = var.nodes_sg_name
  nodes_sg_description = var.nodes_sg_description
  ingress_cp_cidr_blocks = var.ingress_cp_cidr_blocks
  egress_cidr_blocks       = var.nodes_sg_egress_cidr_blocks
}

module "iam" {
  source = "./modules/iam"
  tags   = var.tags
  cluster_role_name        = var.cluster_role_name
  cluster_role_policy_arns = var.cluster_role_policy_arns
  node_role_name           = var.node_role_name
  node_role_policy_arns    = var.node_role_policy_arns
}

module "eks" {
  source                   = "./modules/eks"
  cluster_name             = var.cluster_name
  cluster_version          = var.cluster_version
  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  public_subnet_ids        = module.vpc.public_subnet_ids
  node_group_instance_types = var.node_group_instance_types
  node_group_desired       = var.node_group_desired
  node_group_min           = var.node_group_min
  node_group_max           = var.node_group_max
  node_sg_id               = module.security_groups.nodes_sg_id
  cluster_role_arn         = module.iam.cluster_role_arn
  node_role_arn            = module.iam.node_role_arn
  node_group_name          = var.node_group_name
  enable_public_endpoint   = var.enable_public_endpoint
  # Advanced endpoint controls
  endpoint_private_access  = var.endpoint_private_access
  endpoint_public_access   = var.endpoint_public_access
  public_access_cidrs      = var.public_access_cidrs
  enabled_cluster_log_types = var.enabled_cluster_log_types
  # Node AMI and optional SSH
  ami_type                 = var.ami_type
  ec2_ssh_key              = var.ec2_ssh_key
  node_ssh_source_security_group_ids = var.node_ssh_source_security_group_ids
  tags                     = var.tags
}

# Optional: Create S3 gateway endpoint in private route tables
module "vpc_endpoints" {
  source          = "./modules/vpc_endpoints"
  vpc_id          = module.vpc.vpc_id
  route_table_ids = [module.vpc.private_route_table_id]
  tags            = var.tags
  endpoint_name   = var.s3_endpoint_name
  subnet_ids      = module.vpc.private_subnet_ids
  vpc_cidr        = var.vpc_cidr
  interface_endpoints         = var.interface_endpoints
  interface_vpc_endpoint_type = var.interface_vpc_endpoint_type
  private_dns_enabled         = var.private_dns_enabled
  endpoints_sg_name           = var.endpoints_sg_name
  endpoints_sg_description    = var.endpoints_sg_description
  endpoints_ingress_cidr_blocks  = var.endpoints_ingress_cidr_blocks
  endpoints_egress_cidr_blocks   = var.endpoints_egress_cidr_blocks
}

# Optional: Bastion Host EC2 instance in a public subnet
module "bastion" {
  source                 = "./modules/bastion"
  enable                 = var.bastion_enable
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.public_subnet_ids[0]
  name_prefix            = var.name_prefix
  tags                   = var.tags
  instance_type          = var.bastion_instance_type
  ami_id                 = var.bastion_ami_id
  key_name               = var.bastion_key_name
  allowed_ssh_cidrs      = var.bastion_allowed_ssh_cidrs
  associate_public_ip    = var.bastion_associate_public_ip
  ssh_port               = var.bastion_ssh_port
  egress_cidr_blocks     = var.bastion_egress_cidr_blocks
}
