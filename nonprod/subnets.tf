resource "aws_subnet" "nonprod_subnet" {
  vpc_id                  = aws_vpc.nonprod_vpc.id
  cidr_block              = "10.1.0.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "nonprod_subnet"
  }
}