###################
# WEB
###################

resource "aws_ebs_volume" "web_a_ebs" {
  availability_zone = "ca-central-1a"
  type              = "standard"
  size              = 2
  encrypted         = true
  kms_key_id        = aws_kms_key.web_a_ebs_key.arn

  tags = {
    Name = "web_a_ebs"
  }
}

resource "aws_volume_attachment" "web_a_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_a_ebs.id
  instance_id = aws_instance.web_a.id
}


resource "aws_ebs_volume" "web_b_ebs" {
  availability_zone = "ca-central-1b"
  type              = "standard"
  size              = 2
  encrypted         = true
  kms_key_id        = aws_kms_key.web_b_ebs_key.arn

  tags = {
    Name = "web_b_ebs"
  }
}

resource "aws_volume_attachment" "web_b_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_b_ebs.id
  instance_id = aws_instance.web_b.id
}