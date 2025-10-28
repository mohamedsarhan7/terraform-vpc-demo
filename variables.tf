variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
  
}

variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
  default     = "default"
}

variable "project_name" {
  description = "Name prefix for all resources"
  default     = "backend"
}