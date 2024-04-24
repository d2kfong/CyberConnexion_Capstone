output "onprem_vpc" {
  value = aws_vpc.onprem_vpc
  description = "The on-premise VPC."
}

output "onprem_cidr" {
  value = aws_vpc.onprem_vpc.cidr_block
  description = "The CIDR block of the on-premise VPC."
}

output "strongSwan_ip" {
  value = aws_eip.strongSwan_eip.public_ip
  description = "The IP address of the strongSwan instance."
}

output "customer_gw" {
  value = aws_customer_gateway.customer_gw
  description = "The customer gateway for the site-to-site VPN connection."
}