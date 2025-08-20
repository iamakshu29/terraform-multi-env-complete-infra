# db_subnet_group - Required Resource for RDS
resource "aws_db_subnet_group" "example" {
  name       = "example-subnet-group"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]

  tags = {
    Name = "example-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "default" {
  allocated_storage     = 15
  max_allocated_storage = 20

  # required Argument for custom VPC
  db_subnet_group_name = aws_subnet.main.id
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  multi_az             = true

  # Argument to enable managing the master password with Secrets Manager.
  manage_master_user_password = true

  # remove password Argument if using Secrets Manager.
  #   password = "foobarbaz"

  #  Attribute to specify an RDS, which KMS key to use to encrypt the secret integrated with Secret Manager.
  master_user_secret_kms_key_id = aws_kms_key.example.key_id

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = {
    Name = "default-rds-db"
  }
}
