output "proxy_instance_ids" {
  description = "List of proxy instance IDs"
  value       = aws_instance.proxy[*].id
}

output "proxy_public_ips" {
  description = "List of proxy public IPs"
  value       = aws_instance.proxy[*].public_ip
}

output "proxy_private_ips" {
  description = "List of proxy private IPs"
  value       = aws_instance.proxy[*].private_ip
}