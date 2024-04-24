resource "aws_eip" "nat_eip_a" {
  #domain = "vpc"

  tags = {
    Name = "nat_eip_a"
  }
}

resource "aws_eip" "nat_eip_b" {
  #domain = "vpc"

  tags = {
    Name = "nat_eip_b"
  }
}