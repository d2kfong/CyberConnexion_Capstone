resource "aws_security_group" "nonprod_sg" {
  name        = "nonprod_sg"
  description = "On-premise access"
  vpc_id      = aws_vpc.nonprod_vpc.id

  tags = {
    Name = "nonprod_sg"
  }
}

resource "aws_security_group_rule" "nonprod_allow_in" {
  type              = "ingress"
  description       = "All on-prem traffic in"
  security_group_id = aws_security_group.nonprod_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ var.onprem_cidr ]
}

resource "aws_security_group_rule" "nonprod_allow_out" {
  type              = "egress"
  description       = "All on-prem traffic out"
  security_group_id = aws_security_group.nonprod_sg.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = [ var.onprem_cidr ]
}