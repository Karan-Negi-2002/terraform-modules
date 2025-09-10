data "aws_region" "current" {}

# S3 Gateway endpoint for private route tables
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.id}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags              = merge(var.tags, { Name = var.endpoint_name })
}

# Security group for Interface endpoints (if requested)
resource "aws_security_group" "endpoints" {
  count       = length(var.interface_endpoints) > 0 ? 1 : 0
  name        = var.endpoints_sg_name
  description = var.endpoints_sg_description
  vpc_id      = var.vpc_id

  # Allow TLS from provided ingress CIDRs or fall back to VPC CIDR
  dynamic "ingress" {
    for_each = length(var.endpoints_ingress_cidr_blocks) > 0 ? var.endpoints_ingress_cidr_blocks : (var.vpc_cidr == null ? [] : [var.vpc_cidr])
    content {
      description = "VPC/Specified CIDRs to Interface Endpoints"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "egress" {
    for_each = var.endpoints_egress_cidr_blocks
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value]
    }
  }

  tags = merge(var.tags, { Name = var.endpoints_sg_name })
}

locals {
  interface_endpoint_services = toset(var.interface_endpoints)
}

resource "aws_vpc_endpoint" "interface" {
  for_each          = local.interface_endpoint_services
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.id}.${each.value}"
  vpc_endpoint_type = var.interface_vpc_endpoint_type
  private_dns_enabled = var.private_dns_enabled

  subnet_ids          = var.subnet_ids
  security_group_ids  = length(var.interface_endpoints) > 0 ? [aws_security_group.endpoints[0].id] : []

  tags = merge(var.tags, { Name = "${each.value}-endpoint" })
}

output "s3_endpoint_id" { value = aws_vpc_endpoint.s3.id }
output "interface_endpoint_ids" {
  value = { for k, ep in aws_vpc_endpoint.interface : k => ep.id }
}
