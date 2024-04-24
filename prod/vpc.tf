provider "aws" {
  region  = "ca-central-1"
}

resource "aws_vpc" "prod_vpc" {
  cidr_block         = "10.0.0.0/16"
  instance_tenancy   = "default"
  enable_dns_support = true

  tags = {
    Name = "prod_vpc"
  }
}