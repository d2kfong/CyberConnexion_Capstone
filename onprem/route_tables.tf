resource "aws_route_table" "strongSwan_route_table" {
  vpc_id = aws_vpc.onprem_vpc.id

#  route {
#    cidr_block = var.prod_cidr
#    network_interface_id = aws_instance.strongSwan.primary_network_interface_id
#  }
#
#  route {
#    cidr_block = var.nonprod_cidr
#    network_interface_id = aws_instance.strongSwan.primary_network_interface_id
#  }
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.onprem_vpc_igw.id
  }

  tags = {
    Name = "strongSwan_route_table"
  }
}

resource "aws_route_table_association" "strongSwan_rt_assoc" {
  subnet_id      = aws_subnet.strongSwan_subnet.id
  route_table_id = aws_route_table.strongSwan_route_table.id
}



resource "aws_route_table" "workload_route_table" {
  vpc_id = aws_vpc.onprem_vpc.id

#  route {
#    cidr_block = var.prod_cidr
#    network_interface_id = aws_instance.strongSwan.primary_network_interface_id
#  }
#
#  route {
#    cidr_block = var.nonprod_cidr
#    network_interface_id = aws_instance.strongSwan.primary_network_interface_id
#  }
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_onprem.id
  }

  tags = {
    Name = "workload_route_table"
  }
}

resource "aws_route_table_association" "workload_rt_assoc" {
  subnet_id      = aws_subnet.workload_subnet.id
  route_table_id = aws_route_table.workload_route_table.id
}