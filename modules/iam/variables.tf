variable "tags" {
  type    = map(string)
  default = {}
}

variable "cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  type        = string
}

variable "cluster_role_policy_arns" {
  description = "Policy ARNs to attach to cluster role"
  type        = list(string)
}

variable "node_role_name" {
  description = "Name of the EKS nodegroup IAM role"
  type        = string
}

variable "node_role_policy_arns" {
  description = "Policy ARNs to attach to node role"
  type        = list(string)
}
