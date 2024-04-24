resource "aws_nat_gateway" "ngw_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.web_subnet_a.id
  depends_on = [ aws_internet_gateway.prod_vpc_igw ]

  tags = {
    Name = "ngw_a"
  }
}

resource "aws_nat_gateway" "ngw_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.web_subnet_b.id
  depends_on = [ aws_internet_gateway.prod_vpc_igw ]

  tags = {
    Name = "ngw_b"
  }
}