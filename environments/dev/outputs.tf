output "instance_pub_ip" {
  description = "Public IP of the Dev Web Server"
  value       = module.my-web-server.instance_public_ips
}

output "instance_prv_ip" {
  description = "Private IP of the Dev Web Server"
  value       = module.my-web-server.instance_private_ips
}