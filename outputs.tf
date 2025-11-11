output "public_alb_dns" {
  description = "Public ALB DNS name"
  value       = module.load_balancers.public_alb_dns
}

output "proxy_public_ips" {
  description = "Public IPs of proxy instances"
  value       = module.proxy.proxy_public_ips
}

output "backend_private_ips" {
  description = "Private IPs of backend instances"
  value       = module.backend_app.backend_private_ips
}

output "all_ips_file" {
  description = "Path to the generated IPs file"
  value       = local_file.ips_file.filename
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}