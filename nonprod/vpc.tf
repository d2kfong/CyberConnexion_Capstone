provider "aws" {
  region  = "ca-central-1"
}

resource "aws_vpc" "nonprod_vpc" {
  cidr_block         = "10.1.0.0/16"
  instance_tenancy   = "default"
  enable_dns_support = true

  tags = {
    Name = "nonprod_vpc"
  }
}