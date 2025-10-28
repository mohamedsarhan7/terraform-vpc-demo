variable "vpc_id" {}
variable "subnet_id" {}
variable "routes" {
  type = list(object({
    cidr_block     = string
    gateway_id     = optional(string)
    nat_gateway_id = optional(string)
  }))
}
variable "route_table_type" {}
variable "project_name" {}