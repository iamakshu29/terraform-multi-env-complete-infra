# db_subnet_group - Required Resource for RDS
resource "aws_db_subnet_group" "test_rds" {
  for_each   = var.rds.test_rds
  name       = each.value.name
  subnet_ids = var.subnet_ids

  tags = each.value.tags
}

# RDS Instance
resource "aws_db_instance" "test_db_instance" {
  for_each = var.rds.test_db_instance

  allocated_storage     = 15
  max_allocated_storage = 20

  # required Argument for custom VPC
  db_subnet_group_name = aws_db_subnet_group.test_rds["rds"].name
  db_name              = each.value.db_name
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  username             = each.value.username
# remove password Argument if using Secrets Manager.
  # password             = each.value.password
  multi_az             = try(each.value.multi_az,false)

  # Argument to enable managing the master password with Secrets Manager.
  manage_master_user_password = true

  #  Attribute to specify an RDS, which KMS key to use to encrypt the secret integrated with Secret Manager.
  master_user_secret_kms_key_id = var.kms_key_id

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  tags = each.value.tags
}
