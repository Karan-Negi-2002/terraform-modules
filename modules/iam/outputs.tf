output "cluster_role_arn" {
  value = aws_iam_role.karan_eks_cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.karan_node_group.arn
}
