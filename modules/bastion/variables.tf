variable "enable" {
  description = "Whether to create the bastion host"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID to place the bastion in"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID (typically a public subnet) for the bastion"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming bastion resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to bastion resources"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "EC2 instance type for the bastion"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Optional AMI ID to use for the bastion. If empty, latest Amazon Linux 2 is used"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = ""
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed to SSH (22) into the bastion"
  type        = list(string)
  default     = []
}

variable "associate_public_ip" {
  description = "Associate a public IP with the bastion instance"
  type        = bool
  default     = true
}

variable "ssh_port" {
  description = "SSH port for bastion access"
  type        = number
  default     = 22
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks for bastion SG egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
