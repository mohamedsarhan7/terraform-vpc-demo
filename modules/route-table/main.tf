resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block     = route.value.cidr_block
      gateway_id     = lookup(route.value, "gateway_id", null)
      nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
    }
  }
  
  tags = {
    Name = "${var.project_name}-${var.route_table_type}-rt"
  }
}
resource "aws_route_table_association" "this" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.this.id
}