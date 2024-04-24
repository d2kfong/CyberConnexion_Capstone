provider "aws" {
  region  = "ca-central-1"
}

resource "aws_vpc" "onprem_vpc" {
  cidr_block         = "192.168.0.0/16"
  instance_tenancy   = "default"
  enable_dns_support = true

  tags = {
    Name = "onprem_vpc"
  }
}