variable "cluster_name" { type = string }
variable "cluster_version" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "public_subnet_ids" { type = list(string) }
variable "node_group_instance_types" { type = list(string) }
variable "node_group_desired" { type = number }
variable "node_group_min" { type = number }
variable "node_group_max" { type = number }
variable "node_sg_id" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "enable_public_endpoint" {
  type = bool
}
variable "tags" {
  type = map(string)
}

variable "node_group_name" {
  description = "Name of the managed node group"
  type        = string
}
