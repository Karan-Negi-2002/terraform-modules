output "security_group_id" {
  value = try(aws_security_group.bastion_ssh[0].id, null)
}

output "instance_id" {
  value = try(aws_instance.bastion[0].id, null)
}

output "public_ip" {
  value = try(aws_instance.bastion[0].public_ip, null)
}
