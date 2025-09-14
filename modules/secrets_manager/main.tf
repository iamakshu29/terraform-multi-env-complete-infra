# To manage a secret
resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "rds-credentials"
  description = "RDS database credentials"
  kms_key_id = var.kms_key_id
}

# To manage a secret value
resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = "dbadmin"
    random_password = "RdsPassw0rd!"
  })
}

# To manage a secret rotation
# resource "aws_secretsmanager_secret_rotation" "rds_rotation" {
#   secret_id           = aws_secretsmanager_secret.rds_secret.id
#   rotation_lambda_arn = aws_lambda_function.rds_rotation_lambda.arn
#   rotation_rules {
#     automatically_after_days = 30
#   }
# }
