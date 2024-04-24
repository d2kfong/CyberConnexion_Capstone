###################
# WEB
###################

resource "aws_instance" "web_a" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = true
    subnet_id = aws_subnet.web_subnet_a.id
    private_ip = "10.0.0.4"

    key_name = "web_a_kp"

    vpc_security_group_ids = [ aws_security_group.web_SG.id ]

    tags = {
        Name = "web_a"
    }
}

resource "aws_instance" "web_b" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = true
    subnet_id = aws_subnet.web_subnet_b.id
    private_ip = "10.0.1.4"

    key_name = "web_b_kp"

    vpc_security_group_ids = [ aws_security_group.web_SG.id ]

    tags = {
        Name = "web_b"
    }
}

###################
# APP
###################

resource "aws_instance" "app_a" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.app_subnet_a.id
    private_ip = "10.0.2.4"

    key_name = "app_a_kp"

    vpc_security_group_ids = [ aws_security_group.app_SG.id ]

    tags = {
        Name = "app_a"
    }
}

resource "aws_instance" "app_b" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.app_subnet_b.id
    private_ip = "10.0.3.4"

    key_name = "app_b_kp"

    vpc_security_group_ids = [ aws_security_group.app_SG.id ]

    tags = {
        Name = "app_b"
    }
}