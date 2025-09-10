# Additional root variables to remove hardcoded values across modules

# VPC toggles and routing
variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames on the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support on the VPC"
  type        = bool
  default     = true
}

variable "public_route_cidr" {
  description = "Destination CIDR for public route to Internet Gateway"
  type        = string
  default     = "0.0.0.0/0"
}

variable "private_route_cidr" {
  description = "Destination CIDR for private route to NAT Gateway"
  type        = string
  default     = "0.0.0.0/0"
}

# Nodes Security Group egress
variable "nodes_sg_egress_cidr_blocks" {
  description = "CIDR blocks for nodes Security Group egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Interface Endpoints SG tuning
variable "endpoints_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access Interface Endpoints SG on 443; if empty, falls back to VPC CIDR"
  type        = list(string)
  default     = []
}

variable "endpoints_egress_cidr_blocks" {
  description = "CIDR blocks for Interface Endpoints SG egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Bastion extras
variable "bastion_ssh_port" {
  description = "SSH port for bastion SG"
  type        = number
  default     = 22
}

variable "bastion_egress_cidr_blocks" {
  description = "CIDR blocks for bastion SG egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
