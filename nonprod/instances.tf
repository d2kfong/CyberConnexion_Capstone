resource "aws_instance" "instance_1" {
    ami = "ami-0d78d8707cd9c1be8"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.nonprod_subnet.id
    private_ip = "10.1.0.4"

    vpc_security_group_ids = [ aws_security_group.nonprod_sg.id ]

    tags = {
        Name = "instance_1"
    }
}

resource "aws_instance" "instance_2" {
    ami = "ami-081650ae0104087a4"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.nonprod_subnet.id
    private_ip = "10.1.0.5"

    vpc_security_group_ids = [ aws_security_group.nonprod_sg.id ]

    tags = {
        Name = "instance_2"
    }
}

resource "aws_instance" "instance_3" {
    ami = "ami-0ea18256de20ecdfc"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.nonprod_subnet.id
    private_ip = "10.1.0.6"

    vpc_security_group_ids = [ aws_security_group.nonprod_sg.id ]

    tags = {
        Name = "instance_3"
    }
}

resource "aws_instance" "instance_4" {
    ami = "ami-09c40b417f67a15b3"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.nonprod_subnet.id
    private_ip = "10.1.0.7"

    vpc_security_group_ids = [ aws_security_group.nonprod_sg.id ]

    tags = {
        Name = "instance_4"
    }
}

resource "aws_instance" "instance_5" {
    ami = "ami-0f4433d9ed7b47aab"
    instance_type = "t2.micro"

    associate_public_ip_address = false
    subnet_id = aws_subnet.nonprod_subnet.id
    private_ip = "10.1.0.8"

    vpc_security_group_ids = [ aws_security_group.nonprod_sg.id ]

    tags = {
        Name = "instance_5"
    }
}