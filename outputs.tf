output "vpc_id" { value = module.vpc.vpc_id }
output "private_subnet_ids" { value = module.vpc.private_subnet_ids }
output "public_subnet_ids" { value = module.vpc.public_subnet_ids }
output "eks_cluster_name" { value = module.eks.cluster_name }
output "eks_cluster_endpoint" { value = module.eks.cluster_endpoint }
output "eks_cluster_ca_data" { value = module.eks.cluster_certificate_authority }

# Render kubeconfig content using the provided template
output "kubeconfig" {
  value = templatefile("${path.module}/kubeconfig.tpl", {
    cluster_endpoint = module.eks.cluster_endpoint,
    ca_data          = module.eks.cluster_certificate_authority,
    cluster_name     = var.cluster_name,
    region           = var.aws_region
  })
  sensitive = true
}
