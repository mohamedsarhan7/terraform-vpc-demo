variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB Security Group ID"
  type        = string
}

variable "eic_endpoint_sg_id" {
  description = "EIC Endpoint Security Group ID"
  type        = string
  
}