resource "aws_security_group" "nodes" {
  name        = var.nodes_sg_name
  description = var.nodes_sg_description
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow node to node communication within VPC
  ingress {
    description = "Node to node within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(var.tags, { Name = var.nodes_sg_name })
}
