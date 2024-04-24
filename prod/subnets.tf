###################
# WEB
###################

resource "aws_subnet" "web_subnet_a" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "web_subnet_a"
  }
}

resource "aws_subnet" "web_subnet_b" {
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "web_subnet_b"
  }
}

###################
# APP
###################

resource "aws_subnet" "app_subnet_a" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "app_subnet_a"
  }
}

resource "aws_subnet" "app_subnet_b" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ca-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "app_subnet_b"
  }
}

###################
# DATABASE
###################

resource "aws_subnet" "db_subnet_a" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ca-central-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "db_subnet_a"
  }
}

resource "aws_subnet" "db_subnet_b" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ca-central-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "db_subnet_b"
  }
}