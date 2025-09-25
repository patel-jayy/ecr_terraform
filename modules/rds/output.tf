output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.app_db.address
}

output "db_secret_arn" {
  description = "ARN of Secrets Manager DB secret"
  value       = aws_secretsmanager_secret.db_secret.arn
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}
