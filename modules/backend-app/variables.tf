variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "backend_sg_id" {
  description = "Security group ID for backend instances"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "instance_count" {
  description = "Number of backend instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "internal_alb_dns" {
  description = "Internal ALB DNS name"
  type        = string
}

variable "backend_target_group_arn" {
  description = "ARN of backend target group"
  type        = string
}

variable "bastion_host" {
  description = "Bastion host public IP for SSH access"
  type        = string
  default     = ""
}