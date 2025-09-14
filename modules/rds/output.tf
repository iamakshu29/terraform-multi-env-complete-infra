output "db_secret_arns" {
  description = "Secrets Manager ARNs for the RDS master user passwords"
  value = {
    for k, db in aws_db_instance.test_db_instance :
    k => db.master_user_secret[0].secret_arn
  }
}
