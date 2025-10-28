

resource "aws_security_group" "eic_endpoint_sg" {
  name        = "${var.project_name}-eic-sg"
  description = "Security group for EC2 instance"
  vpc_id     = var.vpc_id

  ingress {
    description = "Allow SSH from EC2 SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
