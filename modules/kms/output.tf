output "kms_key_id" {
  value = aws_kms_key.test_kms_key.id
}

output "kms_key_arn" {
  description = "ARN of the KMS key for RDS"
  value       = aws_kms_key.test_kms_key.arn
}