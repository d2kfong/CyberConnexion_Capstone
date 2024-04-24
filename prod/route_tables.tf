resource "aws_route_table" "web_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
  
  route {
    cidr_block = var.nonprod_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = var.onprem_cidr
    gateway_id = var.transit_gw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_vpc_igw.id
  }

  tags = {
    Name = "web_route_table"
  }
}

resource "aws_route_table_association" "web_a_rt_assoc" {
  subnet_id      = aws_subnet.web_subnet_a.id
  route_table_id = aws_route_table.web_route_table.id
}

resource "aws_route_table_association" "web_b_rt_assoc" {
  subnet_id      = aws_subnet.web_subnet_b.id
  route_table_id = aws_route_table.web_route_table.id
}



resource "aws_route_table" "az_a_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
  
  route {
    cidr_block = var.nonprod_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = var.onprem_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_a.id
  }

  tags = {
    Name = "az_a_route_table"
  }
}

resource "aws_route_table_association" "app_a_rt_assoc" {
  subnet_id      = aws_subnet.app_subnet_a.id
  route_table_id = aws_route_table.az_a_route_table.id
}

resource "aws_route_table_association" "db_a_rt_assoc" {
  subnet_id      = aws_subnet.db_subnet_a.id
  route_table_id = aws_route_table.az_a_route_table.id
}



resource "aws_route_table" "az_b_route_table" {
  vpc_id = aws_vpc.prod_vpc.id
  
  route {
    cidr_block = var.nonprod_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = var.onprem_cidr
    gateway_id = var.transit_gw.id
  }
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_b.id
  }

  tags = {
    Name = "az_b_route_table"
  }
}

resource "aws_route_table_association" "app_b_rt_assoc" {
  subnet_id      = aws_subnet.app_subnet_b.id
  route_table_id = aws_route_table.az_b_route_table.id
}

resource "aws_route_table_association" "db_b_rt_assoc" {
  subnet_id      = aws_subnet.db_subnet_b.id
  route_table_id = aws_route_table.az_b_route_table.id
}