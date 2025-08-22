# To manage a secret
resource "aws_secretsmanager_secret" "example" {
  name = "example"
  description = "this is the secrets manager for DB resource RDS"
  kms_key_id = aws_kms_key.example.arn
}

# To manage a secret rotation
resource "aws_secretsmanager_secret_rotation" "example" {
  secret_id           = aws_secretsmanager_secret.example.id
#   rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

# To manage a secret value
resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = "example-string-to-protect"
}