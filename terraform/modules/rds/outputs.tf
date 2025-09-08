output "db_password" {
  description = "Randomly generated RDS master password"
  value       = random_password.rds_password.result
  sensitive   = true
}

output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.postgres.endpoint
}
