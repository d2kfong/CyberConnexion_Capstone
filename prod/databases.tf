resource "aws_db_subnet_group" "db_subnet_gp" {
  name        = "db_subnet_gp"
  description = "Subnet group containing the two databases"
  subnet_ids  = [ aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id ]

  tags = {
    Name = "db_subnet_gp"
  }
}

resource "aws_db_instance" "db_a" {
  allocated_storage    = 20
  db_name              = "db_a"
  identifier           = "db-a" 
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  final_snapshot_identifier = "db-a-snapshot"
  availability_zone    = "ca-central-1a"

  storage_encrypted    = true
  kms_key_id           = aws_kms_key.db_a_key.arn

  username             = "db_a_admin"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.db_a_pw_key.key_id

  vpc_security_group_ids = [ aws_security_group.db_SG.id ]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_gp.name
}

resource "aws_db_instance" "db_b" {
  allocated_storage    = 20
  db_name              = "db_b"
  identifier           = "db-b" 
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  final_snapshot_identifier = "db-b-snapshot"
  availability_zone    = "ca-central-1b"

  storage_encrypted    = true
  kms_key_id           = aws_kms_key.db_b_key.arn

  username             = "db_b_admin"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.db_b_pw_key.key_id

  vpc_security_group_ids = [ aws_security_group.db_SG.id ]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_gp.name
}