

###################
# ALB
###################

resource "aws_security_group" "alb_SG" {
  name        = "alb_SG"
  description = "Internet HTTP access via App Load Balancer"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "alb_SG"
  }
}

resource "aws_security_group_rule" "alb_HTTP_in" {
  type              = "ingress"
  description       = "HTTP from internet"
  security_group_id = aws_security_group.alb_SG.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_to_web_HTTP" {
  type              = "egress"
  description       = "HTTP and health checks to app tier"
  security_group_id = aws_security_group.alb_SG.id

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_SG.id
}




###################
# WEB
###################

resource "aws_security_group" "web_SG" {
  name        = "web_SG"
  description = "Internet HTTP access and jumpbox SSH capabilities"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "web_SG"
  }
}

resource "aws_security_group_rule" "web_from_alb_HTTP" {
  type              = "ingress"
  description       = "HTTP from app load balancer"
  security_group_id = aws_security_group.web_SG.id

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  #cidr_blocks              = [ "0.0.0.0/0" ]
  source_security_group_id = aws_security_group.alb_SG.id
}

resource "aws_security_group_rule" "web_SSH_in" {
  type              = "ingress"
  description       = "SSH from internet"
  security_group_id = aws_security_group.web_SG.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

#needed for installing Nessus agents
resource "aws_security_group_rule" "web_HTTPS_out" {
  type              = "egress"
  description       = "HTTPS to internet"
  security_group_id = aws_security_group.web_SG.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_to_app_HTTP" {
  type              = "egress"
  description       = "HTTP to internet"
  security_group_id = aws_security_group.web_SG.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_to_app_SSH" {
  type              = "egress"
  description       = "SSH to app tier"
  security_group_id = aws_security_group.web_SG.id

  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_SG.id
}




###################
# APP
###################

resource "aws_security_group" "app_SG" {
  name        = "app_SG"
  description = "Web HTTP and MySQL access to database"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "app_SG"
  }
}

resource "aws_security_group_rule" "app_from_web_HTTP" {
  type              = "ingress"
  description       = "HTTP from web tier"
  security_group_id = aws_security_group.app_SG.id

  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_SG.id
}

resource "aws_security_group_rule" "app_from_web_SSH" {
  type              = "ingress"
  description       = "SSH from web tier"
  security_group_id = aws_security_group.app_SG.id

  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_SG.id
}

resource "aws_security_group_rule" "web_HTTP_in" {
  type              = "egress"
  description       = "HTTP to internet"
  security_group_id = aws_security_group.app_SG.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_HTTPS_in" {
  type              = "egress"
  description       = "HTTPS to internet"
  security_group_id = aws_security_group.app_SG.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "app_to_db_MYSQL" {
  type              = "egress"
  description       = "MySQL to db tier"
  security_group_id = aws_security_group.app_SG.id

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.db_SG.id
}




###################
# DATABASE
###################

resource "aws_security_group" "db_SG" {
  name        = "db_SG"
  description = "MySQL access from app"
  vpc_id      = aws_vpc.prod_vpc.id

  tags = {
    Name = "db_SG"
  }
}

resource "aws_security_group_rule" "db_from_app_MYSQL" {
  type              = "ingress"
  description       = "MySQL from app tier"
  security_group_id = aws_security_group.db_SG.id

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_SG.id
}