resource "aws_instance" "jumpbox" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = true
    subnet_id = aws_subnet.strongSwan_subnet.id
    private_ip = "192.168.0.4"

    key_name = "strongSwan_kp"

    vpc_security_group_ids = [ aws_security_group.strongSwan_SG.id ]

    tags = {
        Name = "jumpbox"
    }
}
#
#resource "aws_eip_association" "strongSwan_eip_assoc" {
#  instance_id   = aws_instance.strongSwan.id
#  allocation_id = aws_eip.strongSwan_eip.id
#}

resource "aws_instance" "workload" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.workload_subnet.id
    private_ip = "192.168.0.20"

    key_name = "workload_kp"

    vpc_security_group_ids = [ aws_security_group.workload_SG.id ]

    tags = {
        Name = "workload"
    }
}