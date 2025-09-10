data "aws_iam_policy_document" "eks_cluster_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = var.cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  for_each = toset(var.cluster_role_policy_arns)
  role       = aws_iam_role.eks_cluster.name
  policy_arn = each.key
}

# Node group role
data "aws_iam_policy_document" "eks_nodes_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_nodes" {
  name               = var.node_role_name
  assume_role_policy = data.aws_iam_policy_document.eks_nodes_assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_nodes_policies" {
  for_each = toset(var.node_role_policy_arns)
  role       = aws_iam_role.eks_nodes.name
  policy_arn = each.key
}

output "cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.eks_nodes.arn
}
