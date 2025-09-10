module "vpc" {
  source                = "./modules/vpc"
  cluster_name          = var.cluster_name
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  availability_zones    = var.availability_zones
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
}

module "security_groups" {
  source       = "./modules/security_groups"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
}

module "vpc_endpoints" {
  source                 = "./modules/vpc_endpoints"
  cluster_name           = var.cluster_name
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr               = var.vpc_cidr
  private_subnet_ids     = module.vpc.private_subnet_ids
  route_table_public_id  = module.vpc.route_table_public_id
  route_table_private_id = module.vpc.route_table_private_id
}

module "eks" {
  source                    = "./modules/eks"
  cluster_name              = var.cluster_name
  cluster_version           = var.cluster_version
  aws_region                = var.aws_region
  private_subnet_ids        = module.vpc.private_subnet_ids
  cluster_role_arn          = module.iam.cluster_role_arn
  node_role_arn             = module.iam.node_role_arn
  node_group_instance_types = var.node_group_instance_types
  node_group_desired        = var.node_group_desired
  node_group_min            = var.node_group_min
  node_group_max            = var.node_group_max
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS cluster endpoint (private)"
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "node_group_arn" {
  value = module.eks.node_group_arn
}
