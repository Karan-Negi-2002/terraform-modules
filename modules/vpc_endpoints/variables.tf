variable "vpc_id" { type = string }
variable "route_table_ids" { type = list(string) }
variable "tags" {
  type = map(string)
}

variable "endpoint_name" {
  description = "Name tag for the VPC endpoint"
  type        = string
}
