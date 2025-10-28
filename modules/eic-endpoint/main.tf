resource "aws_ec2_instance_connect_endpoint" "ec2_connect_endpoint" {
  subnet_id         =   var.private_subnet_id
  security_group_ids = [var.eic_endpoint_sg_id]

  tags = {
    Name = "${var.project_name}-eic-endpoint"
  }
}

