data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security group to allow SSH from provided CIDRs
resource "aws_security_group" "bastion_ssh" {
  count       = var.enable ? 1 : 0
  name        = "${var.name_prefix}-bastion-ssh"
  description = "SSH access to bastion"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.allowed_ssh_cidrs
    content {
      description = "SSH from allowed CIDRs"
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "egress" {
    for_each = var.egress_cidr_blocks
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value]
    }
  }

  tags = merge(var.tags, { Name = "${var.name_prefix}-bastion-ssh" })
}

# Bastion EC2 instance
resource "aws_instance" "bastion" {
  count                       = var.enable ? 1 : 0
  ami                         = length(var.ami_id) > 0 ? var.ami_id : data.aws_ami.al2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion_ssh[0].id]
  associate_public_ip_address = var.associate_public_ip
  key_name                    = length(var.key_name) > 0 ? var.key_name : null

  tags = merge(var.tags, { Name = "${var.name_prefix}-bastion" })
}
