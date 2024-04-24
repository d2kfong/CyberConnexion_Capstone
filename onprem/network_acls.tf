##StrongSwan NACL
resource "aws_network_acl" "strongSwan_nacl" {

  vpc_id = aws_vpc.onprem_vpc.id

  ingress {
    protocol        = "-1"
    rule_no         = 20
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 0
    to_port         = 0
  }

  egress {
    protocol        = "-1"
    rule_no         = 20
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 0
    to_port         = 0
  }
  
  # Ingress rule to allow incoming connections from on-prem workload
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 100
  #  action          = "allow"
  #  cidr_block      = "10.0.0.0/28"  # IP range of web tier Az-1
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 110
  #  action          = "allow"
  #  cidr_block      = "10.0.0.0/28"  # IP range of web tier Az-1
  #  from_port       = 22
  #  to_port         = 22
  #}
  #
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 120
  #  action          = "allow"
  #  cidr_block      = "10.0.0.64/28"  # IP range of web tier Az-2
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 130
  #  action          = "allow"
  #  cidr_block      = "10.0.0.64/28"  # IP range of web tier Az-2
  #  from_port       = 22
  #  to_port         = 22
  #}
  #
  ##non-prod subnet
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 140
  #  action          = "allow"
  #  cidr_block      = "10.0.1.0/28"  # IP range of non-prod
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #ingress {
  #  protocol        = "tcp"
  #  rule_no         = 150
  #  action          = "allow"
  #  cidr_block      = "10.0.1.0/28"  # IP range of non-prod subnet
  #  from_port       = 22
  #  to_port         = 22
  #}
 #
 ## Egress rule to allow outgoing connections to strongSwan workload
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 100
  #  action          = "allow"
  #  cidr_block      = "10.0.0.0/28"  # IP range of web tier Az-1
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 110
  #  action          = "allow"
  #  cidr_block      = "10.0.0.0/28"  # IP range of web tier Az-1
  #  from_port       = 22
  #  to_port         = 22
  #}
  #
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 120
  #  action          = "allow"
  #  cidr_block      = "10.0.0.64/28"  # IP range of web tier Az-2
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 130
  #  action          = "allow"
  #  cidr_block      = "10.0.0.64/28"  # IP range of web tier Az-2
  #  from_port       = 22
  #  to_port         = 22
  #}
#
  ##non-prod subnet
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 140
  #  action          = "allow"
  #  cidr_block      = "10.0.1.0/28"  # IP range of non-prod subnet
  #  from_port       = 80
  #  to_port         = 80
  #}
  #
  #egress {
  #  protocol        = "tcp"
  #  rule_no         = 150
  #  action          = "allow"
  #  cidr_block      = "10.0.1.0/28"  # IP range of non-prod subnet
  #  from_port       = 22
  #  to_port         = 22
  #}
 
 tags = {
    Name = "strongSwan_nacl"
  }
}

resource "aws_network_acl_association" "strongSwan_nacl_assoc" {
  subnet_id      = aws_subnet.strongSwan_subnet.id
  network_acl_id = aws_network_acl.strongSwan_nacl.id
}



resource "aws_network_acl" "workload_nacl" {

  vpc_id = aws_vpc.onprem_vpc.id

  ingress {
    protocol        = "-1"
    rule_no         = 20
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 0
    to_port         = 0
  }

  egress {
    protocol        = "-1"
    rule_no         = 20
    action          = "allow"
    cidr_block      = "0.0.0.0/0"
    from_port       = 0
    to_port         = 0
  }
 
 tags = {
    Name = "workload_nacl"
  }
}

resource "aws_network_acl_association" "workload_nacl_assoc" {
  subnet_id      = aws_subnet.workload_subnet.id
  network_acl_id = aws_network_acl.workload_nacl.id
}