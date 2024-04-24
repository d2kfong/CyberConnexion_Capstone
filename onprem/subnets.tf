resource "aws_subnet" "strongSwan_subnet" {
  vpc_id                  = aws_vpc.onprem_vpc.id
  cidr_block              = "192.168.0.0/28"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "strongSwan_subnet"
  }
}

resource "aws_subnet" "workload_subnet" {
  vpc_id                  = aws_vpc.onprem_vpc.id
  cidr_block              = "192.168.0.16/28"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "workload_subnet"
  }
}