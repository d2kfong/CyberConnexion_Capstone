resource "aws_network_acl" "nonprod_nacl" {
  
  vpc_id = aws_vpc.nonprod_vpc.id

  #block all prod traffic
  ingress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.prod_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.prod_cidr
    from_port  = 0
    to_port    = 0
  }

  #allow all on-prem traffic
  ingress {
    protocol   = "-1"
    rule_no    = 40
    action     = "allow"
    cidr_block = var.onprem_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 40
    action     = "allow"
    cidr_block = var.onprem_cidr
    from_port  = 0
    to_port    = 0
  }
  
  tags = {
    Name = "nonprod_nacl"
  }
}

resource "aws_network_acl_association" "nonprod_nacl_assoc" {
  subnet_id      = aws_subnet.nonprod_subnet.id
  network_acl_id = aws_network_acl.nonprod_nacl.id
}