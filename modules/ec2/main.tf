resource "aws_instance" "this" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  # user_data = <<-EOF
  #   #!/bin/bash
  #   echo "Hello from Terraform EC2 startup script!" > /home/ec2-user/startup.log
  #   # Add more commands here
  # EOF

  tags = {
    Name = "${var.project_name}-instance"
  }
}
