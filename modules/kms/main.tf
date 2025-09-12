data "aws_caller_identity" "current" {}

# Symmetric Encryption KMS Key
resource "aws_kms_key" "test_kms_key" {

  description         = var.kms.description
  enable_key_rotation = try(var.kms.key_rotate, false)

  #   default is 1 year
  rotation_period_in_days = try(var.kms.key_rotation_period, 365)

  # delete the key permanently in x days, after we gave the deletion command. default is 30 days
  deletion_window_in_days = 7

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable account root access"
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow key usage by all IAM identities in the account"
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ]
        Resource = "*"
      }
    ]
  })
}
