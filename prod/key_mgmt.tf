###################
# WEB
###################

resource "aws_kms_key" "web_a_ebs_key" {
  
  description             = "web_a EBS volume encryption key" #key filename used for the purposes of our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "web_a_ebs_key" {
  name          = "alias/web_a_ebs_key"
  target_key_id = aws_kms_key.web_a_ebs_key.key_id
}

resource "aws_kms_key" "web_b_ebs_key" {
  description             = "web_b EBS volume encryption key" #key filename used for the purposes of our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "web_b_ebs_key" {
  name          = "alias/web_b_ebs_key"
  target_key_id = aws_kms_key.web_b_ebs_key.key_id
}

###################
# DATABASE
###################

resource "aws_kms_key" "db_a_key" {
  description             = "db_a encryption key" #key filename used for the purposes of our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "db_a_key" {
  name          = "alias/db_a_key"
  target_key_id = aws_kms_key.db_a_key.key_id
}

resource "aws_kms_key" "db_a_pw_key" {
  description             = "db_a secrets manager encryption key" #key filename used for the purposes of our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "db_a_pw_key" {
  name          = "alias/db_a_pw_key"
  target_key_id = aws_kms_key.db_a_pw_key.key_id
}

resource "aws_kms_key" "db_b_key" {
  description             = "db_a encryption key" #key filename used for our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "db_b_key" {
  name          = "alias/db_b_key"
  target_key_id = aws_kms_key.db_b_key.key_id
}

resource "aws_kms_key" "db_b_pw_key" {
  description             = "db_a secrets manager encryption key" #key filename used for the purposes of our project
  key_usage               = "ENCRYPT_DECRYPT"
  deletion_window_in_days = 10

  enable_key_rotation = true
}

resource "aws_kms_alias" "db_b_pw_key" {
  name          = "alias/db_b_pw_key"
  target_key_id = aws_kms_key.db_b_pw_key.key_id
}
