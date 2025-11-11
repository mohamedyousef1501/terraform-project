output "proxy_sg_id" {
  description = "Security group ID for proxy instances"
  value       = aws_security_group.proxy_sg.id
}

output "backend_sg_id" {
  description = "Security group ID for backend instances"
  value       = aws_security_group.backend_sg.id
}

output "public_alb_dns" {
  description = "DNS name of public ALB"
  value       = aws_lb.public_alb.dns_name
}

output "internal_alb_dns" {
  description = "DNS name of internal ALB"
  value       = aws_lb.internal_alb.dns_name
}

output "proxy_target_group_arn" {
  description = "ARN of proxy target group"
  value       = aws_lb_target_group.proxy_tg.arn
}

output "backend_target_group_arn" {
  description = "ARN of backend target group"
  value       = aws_lb_target_group.backend_tg.arn
}