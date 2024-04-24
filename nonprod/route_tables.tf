resource "aws_route_table" "nonprod_route_table" {
  vpc_id = aws_vpc.nonprod_vpc.id
  
  route {
    cidr_block = var.prod_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = var.onprem_cidr
    gateway_id = var.transit_gw.id
  }

  tags = {
    Name = "nonprod_route_table"
  }
}

resource "aws_route_table_association" "nonprod_rt_assoc" {
  subnet_id      = aws_subnet.nonprod_subnet.id
  route_table_id = aws_route_table.nonprod_route_table.id
}