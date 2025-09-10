resource "aws_security_group" "nodes" {
  name        = var.nodes_sg_name
  description = var.nodes_sg_description
  vpc_id      = var.vpc_id

  dynamic "egress" {
    for_each = var.egress_cidr_blocks
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value]
    }
  }

  # Allow node to node communication within VPC
  ingress {
    description = "Node to node within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  # Optional: allow control-plane related traffic to nodes on 443 from provided CIDRs
  dynamic "ingress" {
    for_each = var.ingress_cp_cidr_blocks
    content {
      description = "Control plane to nodes"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  tags = merge(var.tags, { Name = var.nodes_sg_name })
}
