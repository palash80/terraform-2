resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
}
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
}
resource "aws_route_table_association" "public_association" {
  count           = length(var.public_subnet_ids)
  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_association" {
  count           = length(var.private_subnet_ids)
  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id
}
resource "aws_route" "nat_gateway" {
  #count           = length(var.private_subnet_ids)
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.nat_id

}