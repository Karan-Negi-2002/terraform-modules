resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = [var.node_sg_id]
  }

  enabled_cluster_log_types = var.enabled_cluster_log_types

  tags = var.tags
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.node_group_desired
    min_size     = var.node_group_min
    max_size     = var.node_group_max
  }

  instance_types = var.node_group_instance_types
  ami_type       = var.ami_type

  dynamic "remote_access" {
    for_each = length(var.ec2_ssh_key) > 0 && length(var.node_ssh_source_security_group_ids) > 0 ? [1] : []
    content {
      ec2_ssh_key               = var.ec2_ssh_key
      source_security_group_ids = var.node_ssh_source_security_group_ids
    }
  }
  tags           = var.tags
}

output "cluster_name" { value = aws_eks_cluster.this.name }
output "cluster_endpoint" { value = aws_eks_cluster.this.endpoint }
output "cluster_certificate_authority" { value = aws_eks_cluster.this.certificate_authority[0].data }
