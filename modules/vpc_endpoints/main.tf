# Minimal S3 Gateway endpoint for private subnets
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.id}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.route_table_ids
  tags = merge(var.tags, { Name = var.endpoint_name })
}

data "aws_region" "current" {}

output "s3_endpoint_id" { value = aws_vpc_endpoint.s3.id }
