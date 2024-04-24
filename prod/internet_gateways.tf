resource "aws_internet_gateway" "prod_vpc_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  
  tags = {
    Name = "prod_vpc_igw"
  }
}