resource "aws_eip" "nat_eip" {
  #domain = "vpc"

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_eip" "strongSwan_eip" {
  #domain = "vpc"

  tags = {
    Name = "strongSwan_eip"
  }
}