###################
# WEB TIER
###################

resource "aws_network_acl" "web_nacl" {

  vpc_id = aws_vpc.prod_vpc.id

  ingress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }
  
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
  # HTTPS traffic from app tier going through NAT gw
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = aws_subnet.app_subnet_a.cidr_block
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = aws_subnet.app_subnet_b.cidr_block
    from_port  = 443
    to_port    = 443
  }
  
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  
  egress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  tags = {
    Name = "web_nacl"
  }
}

resource "aws_network_acl_association" "web_a_nacl_assoc" {
  subnet_id      = aws_subnet.web_subnet_a.id
  network_acl_id = aws_network_acl.web_nacl.id
}

resource "aws_network_acl_association" "web_b_nacl_assoc" {
  subnet_id      = aws_subnet.web_subnet_b.id
  network_acl_id = aws_network_acl.web_nacl.id
}



###################
# APP TIER AZ1a
###################

resource "aws_network_acl" "app_a_nacl" {

  vpc_id = aws_vpc.prod_vpc.id

  ingress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }
  
  # HTTP requests from app tier
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_a.cidr_block
    from_port  = 80
    to_port    = 80
  }
  
  # SSH requests from app tier
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_a.cidr_block
    from_port  = 22
    to_port    = 22
  }
  
  # MySQL responses from db tier
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_a.cidr_block
    from_port  = 3306
    to_port    = 3306
  }
  
  # MySQL responses from db tier
  ingress {
    protocol   = "tcp"
    rule_no    = 160
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_b.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # HTTP/S responses
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  # HTTP requests to internet (for curl)
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
  # HTTPS requests to internet (for curl)
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # MySQL requests to db tier
  egress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_a.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # MySQL requests to db tier
  egress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_b.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # SSH responses to web tier
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_a.cidr_block
    from_port  = 1024
    to_port    = 65535
  }
  
  tags = {
    Name = "app_a_nacl"
  }
}

resource "aws_network_acl_association" "app_a_nacl_assoc" {
  subnet_id      = aws_subnet.app_subnet_a.id
  network_acl_id = aws_network_acl.app_a_nacl.id
}


###################
# APP TIER AZ1b
###################

##App Tier AZ-2!!!
resource "aws_network_acl" "app_b_nacl" {

  vpc_id = aws_vpc.prod_vpc.id

  ingress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 20
    action     = "deny"
    cidr_block = var.nonprod_cidr
    from_port  = 0
    to_port    = 0
  }
  
  # HTTP requests from app tier
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_b.cidr_block
    from_port  = 80
    to_port    = 80
  }
  
  # SSH requests from app tier
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_b.cidr_block
    from_port  = 22
    to_port    = 22
  }
  
  # MySQL responses from db tier
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_a.cidr_block
    from_port  = 3306
    to_port    = 3306
  }
  
  # MySQL responses from db tier
  ingress {
    protocol   = "tcp"
    rule_no    = 160
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_b.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # HTTP/S responses
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  # HTTP requests to internet (for curl)
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  
  # HTTPS requests to internet (for curl)
  egress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # MySQL requests to db tier
  egress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_a.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # MySQL requests to db tier
  egress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = aws_subnet.db_subnet_b.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  # SSH responses to web tier
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = aws_subnet.web_subnet_b.cidr_block
    from_port  = 1024
    to_port    = 65535
  }
  
  tags = {
    Name = "app_b_nacl"
  }
}

resource "aws_network_acl_association" "app_b_nacl_assoc" {
  subnet_id      = aws_subnet.app_subnet_b.id
  network_acl_id = aws_network_acl.app_b_nacl.id
}



#############################
# DB TIER AZ1a
#############################

resource "aws_network_acl" "db_a_nacl" {

  vpc_id = aws_vpc.prod_vpc.id
  
  # Ingress rule to allow incoming MySQL traffic only from the application tier
  ingress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_a.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  ingress {
    protocol        = "tcp"
    rule_no         = 120
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_b.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  # Egress rule to allow outgoing MySQL traffic to the application tier
  egress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_a.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  egress {
    protocol        = "tcp"
    rule_no         = 120
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_b.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  tags = {
    Name = "db_a_nacl"
  }
}

resource "aws_network_acl_association" "db_a_nacl_assoc" {
  subnet_id      = aws_subnet.db_subnet_a.id
  network_acl_id = aws_network_acl.db_a_nacl.id
}



###################
# DB TIER AZ1b
###################

resource "aws_network_acl" "db_b_nacl" {
    
  vpc_id = aws_vpc.prod_vpc.id
  
  # Ingress rule to allow incoming MySQL traffic only from the application tier
  ingress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_a.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  ingress {
    protocol        = "tcp"
    rule_no         = 120
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_b.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  # Egress rule to allow outgoing MySQL traffic to the application tier
  egress {
    protocol        = "tcp"
    rule_no         = 100
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_a.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  egress {
    protocol        = "tcp"
    rule_no         = 120
    action          = "allow"
    cidr_block      = aws_subnet.app_subnet_b.cidr_block
    from_port       = 3306
    to_port         = 3306
  }
  
  tags = {
    Name = "db_b_nacl"
  }
}

resource "aws_network_acl_association" "db_b_nacl_assoc" {
  subnet_id      = aws_subnet.db_subnet_b.id
  network_acl_id = aws_network_acl.db_b_nacl.id
}