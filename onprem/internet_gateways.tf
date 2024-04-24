resource "aws_internet_gateway" "onprem_vpc_igw" {
  vpc_id = aws_vpc.onprem_vpc.id
  
  tags = {
    Name = "onprem_vpc_igw"
  }
}