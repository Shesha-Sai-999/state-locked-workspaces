output "instance_public_ips" {
  description = "Public IP addresses of the deployed servers"
  value       = aws_instance.web_server[*].public_ip
}

output "instance_private_ips" {
  description = "Private IP addresses of the deployed servers"
  value       = aws_instance.web_server[*].private_ip
}

output "instance_ids" {
  description = "IDs of the deployed servers"
  value       = aws_instance.web_server[*].id
}