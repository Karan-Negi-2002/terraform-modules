variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidrs" {
  type = list(string)
}

variable "private_subnets_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
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

variable "cluster_version" {
  type = string
}

# New variables to avoid hardcoded values anywhere
variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "name_prefix" {
  description = "Prefix used for naming resources"
  type        = string
}

# Security Groups module variables
variable "nodes_sg_name" {
  description = "Name for EKS nodes security group"
  type        = string
}

variable "nodes_sg_description" {
  description = "Description for EKS nodes security group"
  type        = string
}

# IAM module variables
variable "cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  type        = string
}

variable "cluster_role_policy_arns" {
  description = "List of policy ARNs to attach to the cluster role"
  type        = list(string)
}

variable "node_role_name" {
  description = "Name of the EKS nodegroup IAM role"
  type        = string
}

variable "node_role_policy_arns" {
  description = "List of policy ARNs to attach to the node role"
  type        = list(string)
}

# EKS module variables
variable "node_group_name" {
  description = "Name for the EKS managed node group"
  type        = string
}

variable "enable_public_endpoint" {
  description = "Whether to enable public endpoint for EKS control plane"
  type        = bool
}

# VPC Endpoints module variables
variable "s3_endpoint_name" {
  description = "Name tag for S3 VPC endpoint"
  type        = string
}

# ----------------------------------------------------------------------------
# Advanced EKS and Networking Options
# ----------------------------------------------------------------------------

variable "endpoint_private_access" {
  description = "Whether the EKS API server endpoint is private"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the EKS API server endpoint is publicly accessible"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the public EKS endpoint (only used when public access is enabled)"
  type        = list(string)
  default     = []
}

variable "enabled_cluster_log_types" {
  description = "List of control plane log types to enable, e.g. [\"api\", \"audit\", \"authenticator\", \"controllerManager\", \"scheduler\"]"
  type        = list(string)
  default     = []
}

variable "ami_type" {
  description = "AMI type for the managed node group (e.g., AL2_x86_64, AL2_x86_64_GPU, BOTTLEROCKET_x86_64, AL2023_x86_64)"
  type        = string
  default     = "AL2_x86_64"
}

variable "ec2_ssh_key" {
  description = "EC2 key pair name to enable SSH access to worker nodes (remote access in managed nodegroups). Leave empty to disable."
  type        = string
  default     = ""
}

variable "node_ssh_source_security_group_ids" {
  description = "Security group IDs that are allowed to SSH into nodes when remote access is enabled. Leave empty to skip remote access configuration."
  type        = list(string)
  default     = []
}

# Security Group tuning
variable "ingress_cp_cidr_blocks" {
  description = "CIDR blocks allowed to reach node group on control-plane related ports (e.g., 443)"
  type        = list(string)
  default     = []
}

# Interface VPC Endpoints configuration
variable "interface_endpoints" {
  description = "List of AWS services to create Interface VPC Endpoints for (short names, e.g., [\"ecr.api\", \"ecr.dkr\", \"sts\"])"
  type        = list(string)
  default     = []
}

variable "interface_vpc_endpoint_type" {
  description = "Type for interface endpoints (normally 'Interface')"
  type        = string
  default     = "Interface"
}

variable "private_dns_enabled" {
  description = "Whether to enable private DNS for Interface endpoints"
  type        = bool
  default     = true
}

variable "endpoints_sg_name" {
  description = "Name for the security group attached to Interface VPC Endpoints"
  type        = string
  default     = "vpc-endpoints-sg"
}

variable "endpoints_sg_description" {
  description = "Description for the Interface Endpoints security group"
  type        = string
  default     = "Security group for VPC Interface Endpoints"
}

# ----------------------------------------------------------------------------
# Bastion Host (EC2) configuration
# ----------------------------------------------------------------------------

variable "bastion_enable" {
  description = "Whether to create the bastion host"
  type        = bool
  default     = true
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "bastion_ami_id" {
  description = "Optional AMI ID for the bastion host. If empty, the module will use latest Amazon Linux 2"
  type        = string
  default     = ""
}

variable "bastion_key_name" {
  description = "EC2 key pair name for SSH access to bastion. Leave empty to disable key association"
  type        = string
  default     = ""
}

variable "bastion_allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH into the bastion (port 22)"
  type        = list(string)
  default     = []
}

variable "bastion_associate_public_ip" {
  description = "Whether to associate a public IP address with the bastion instance"
  type        = bool
  default     = true
}
