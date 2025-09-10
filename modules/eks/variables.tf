variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "node_group_instance_types" {
  type = list(string)
}

variable "node_group_desired" {
  type = number
}

variable "node_group_min" {
  type = number
}

variable "node_group_max" {
  type = number
}
