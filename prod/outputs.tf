output "prod_vpc" {
  value = aws_vpc.prod_vpc
  description = "The prod VPC."
}

output "web_subnet_a" {
  value = aws_subnet.web_subnet_a
  description = "The web subnet in AZ a."
}

output "web_subnet_b" {
  value = aws_subnet.web_subnet_b
  description = "The web subnet in AZ b."
}