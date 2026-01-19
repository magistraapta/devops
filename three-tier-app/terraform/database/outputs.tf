output "db_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.db.endpoint
}

output "db_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db.port
}

output "db_security_group_id" {
  description = "Security group ID for the database"
  value       = aws_security_group.db-sg.id
}
