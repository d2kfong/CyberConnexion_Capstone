resource "aws_customer_gateway" "customer_gw" {
    bgp_asn    = 65000
    ip_address = aws_eip.strongSwan_eip.public_ip
    type       = "ipsec.1"

    tags = {
        Name = "customer_gw"
    }
}

resource "aws_vpn_gateway" "vpn_gw" {
    vpc_id = aws_vpc.onprem_vpc.id
}