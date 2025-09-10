variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of AZs to deploy subnets. If empty, will use available AZs from the region."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Prefix for naming VPC resources in tags"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
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
