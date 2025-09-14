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
  db_subnet_group_name = "test-rds"
  db_name              = each.value.db_name
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  multi_az             = try(each.value.multi_az,false)
  username = each.value.username

# AWS manages the password, stores it in Secrets Manager, encrypted with this KMS key
  manage_master_user_password = true
  master_user_secret_kms_key_id = var.kms_key_arn # secret encryption

# # Database storage, snapshots, backups encrypted with this KMS key
  storage_encrypted = true
  kms_key_id           = var.kms_key_arn # storage encryption

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  tags = each.value.tags
}
