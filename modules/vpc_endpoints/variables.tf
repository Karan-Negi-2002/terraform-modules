variable "vpc_id" { type = string }
variable "route_table_ids" { type = list(string) }
variable "tags" {
  type = map(string)
}

variable "endpoint_name" {
  description = "Name tag for the VPC endpoint"
  type        = string
}

# Additional inputs for Interface endpoints
variable "subnet_ids" {
  description = "Subnet IDs (typically private) for Interface endpoints"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "VPC CIDR used for endpoint SG rules"
  type        = string
  default     = null
}

variable "interface_endpoints" {
  description = "List of short service names to create interface endpoints for (e.g., [\"ecr.api\", \"ecr.dkr\", \"logs\"])"
  type        = list(string)
  default     = []
}

variable "interface_vpc_endpoint_type" {
  description = "Endpoint type for interface endpoints"
  type        = string
  default     = "Interface"
}

variable "private_dns_enabled" {
  description = "Enable private DNS on interface endpoints"
  type        = bool
  default     = true
}

variable "endpoints_sg_name" {
  description = "Security group name for interface endpoints"
  type        = string
  default     = "vpc-endpoints-sg"
}

variable "endpoints_sg_description" {
  description = "Security group description for interface endpoints"
  type        = string
  default     = "Security group for VPC Interface Endpoints"
}

variable "endpoints_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to reach interface endpoints on 443. If empty, falls back to vpc_cidr when provided."
  type        = list(string)
  default     = []
}

variable "endpoints_egress_cidr_blocks" {
  description = "CIDR blocks for interface endpoints SG egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
