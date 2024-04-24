resource "aws_nat_gateway" "ngw_onprem" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.strongSwan_subnet.id
  depends_on = [ aws_internet_gateway.onprem_vpc_igw ]

  tags = {
    Name = "ngw_onprem"
  }
}