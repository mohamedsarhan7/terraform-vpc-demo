variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "eic_endpoint_sg_id" {
  description = "EIC Endpoint Security Group ID"
  type        = string
}


variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}
