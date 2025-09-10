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

output "bastion_instance_id" {
  value       = try(module.bastion.instance_id, null)
  description = "EC2 instance ID of the bastion host"
}

output "bastion_public_ip" {
  value       = try(module.bastion.public_ip, null)
  description = "Public IP of the bastion host (when enabled)"
}

output "bastion_security_group_id" {
  value       = try(module.bastion.security_group_id, null)
  description = "Security group ID used by the bastion host"
}
