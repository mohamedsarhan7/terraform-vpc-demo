output "sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.alb.id
}