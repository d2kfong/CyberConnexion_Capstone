output "nonprod_vpc" {
  value = aws_vpc.nonprod_vpc
  description = "The non-prod VPC."
}

output "nonprod_subnet" {
  value = aws_subnet.nonprod_subnet
  description = "The subnet resource."
}