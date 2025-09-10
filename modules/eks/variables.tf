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
variable "enable_public_endpoint" { type = bool }
variable "tags" { type = map(string) }

variable "node_group_name" {
  description = "Name of the managed node group"
  type        = string
}

# Advanced EKS options
variable "endpoint_private_access" { type = bool }
variable "endpoint_public_access" { type = bool }
variable "public_access_cidrs" { type = list(string) }
variable "enabled_cluster_log_types" { type = list(string) }
variable "ami_type" { type = string }
variable "ec2_ssh_key" { type = string }
variable "node_ssh_source_security_group_ids" { type = list(string) }
