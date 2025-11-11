variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "proxy_sg_id" {
  description = "Security group ID for proxy instances"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
}

variable "instance_count" {
  description = "Number of proxy instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "proxy_target_group_arn" {
  description = "ARN of proxy target group"
  type        = string
}