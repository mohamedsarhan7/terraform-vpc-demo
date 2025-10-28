# terraform-demo

A small Terraform demo that provisions an AWS VPC, subnets, NAT gateway, routing, an Application Load Balancer (ALB) and an EC2 instance using a modular layout.


## Architecture

This demo provisions:

- An AWS VPC with public and private subnets
- An Application Load Balancer (ALB) in public subnets
- A single EC2 instance in a private subnet
- Internet Gateway (IGW) for public subnets
- NAT Gateway for outbound internet access from private subnets
- EC2 Instance Connect endpoint for secure SSH access to private EC2 instances

 EC2 Instance Connect enables secure, auditable SSH access without direct exposure of private instances.

## Repository structure

- `main.tf`, `provider.tf`, `variables.tf`, `terraform.tfvars` — root composition layer.
- `modules/` — individually scoped modules (vpc, subnet, nat, route-table, security-group, alb, alb-sg, ec2).

Each module has its inputs and outputs; review the module `variables.tf` and `outputs.tf` to see the available parameters and outputs.

## Quick start

Prerequisites:

- Terraform (1.0+ recommended)
- AWS CLI / Credentials (use env vars or a profile)

Basic commands (from repo root):

```bash
terraform init
terraform validate
terraform plan 
terraform apply
```

Destroy resources when done:

```bash
terraform destroy
```

## Variables & tfvars

Edit `terraform.tfvars` to set values appropriate to your account/region. Keep secrets out of the repo; use environment variables or a secrets manager for sensitive values.

## State management

This demo keeps state locally by default
