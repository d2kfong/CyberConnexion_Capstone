###################
# strongSwan VPN
###################

resource "aws_security_group" "strongSwan_SG" {
  name        = "strongSwan_SG"
  description = "VPN traffic"
  vpc_id      = aws_vpc.onprem_vpc.id

  tags = {
    Name = "strongSwan_SG"
  }
}

resource "aws_security_group_rule" "all_from_work" {
  type              = "ingress"
  description       = "All traffic from simulated workload"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.workload_SG.id
}

resource "aws_security_group_rule" "all_from_cloud" {
  type              = "ingress"
  description       = "All traffic from cloud"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ "10.0.0.0/16" ]
}

resource "aws_security_group_rule" "SSH_from_web" {
  type              = "ingress"
  description       = "SSH traffic from the web"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "all_to_work" {
  type              = "egress"
  description       = "All traffic to simulated workload"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.workload_SG.id
}

resource "aws_security_group_rule" "all_to_cloud" {
  type              = "egress"
  description       = "All traffic to cloud"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ "10.0.0.0/24" ]
}

resource "aws_security_group_rule" "HTTP_to_web" {
  type              = "egress"
  description       = "HTTP to web"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "HTTPS_to_web" {
  type              = "egress"
  description       = "HTTPS to web"
  security_group_id = aws_security_group.strongSwan_SG.id

  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}




###################
# Simulated work
###################

resource "aws_security_group" "workload_SG" {
  name        = "workload_SG"
  description = "Outbound traffic"
  vpc_id      = aws_vpc.onprem_vpc.id

  tags = {
    Name = "workload_SG"
  }
}

resource "aws_security_group_rule" "all_from_everywhere" {
  type              = "ingress"
  description       = "All traffic in"
  security_group_id = aws_security_group.workload_SG.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "all_to_everywhere" {
  type              = "egress"
  description       = "All traffic out"
  security_group_id = aws_security_group.workload_SG.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}