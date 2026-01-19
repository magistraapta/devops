output "app_public_ip" {
  description = "Public IP of the Nginx server"
  value       = aws_instance.app.public_ip
}

output "app_public_dns" {
  description = "Public DNS of the Nginx server"
  value       = aws_instance.app.public_dns
}

output "app_private_ip" {
  description = "Private IP of the application server"
  value       = aws_instance.app.private_ip
}

output "app_security_group_id" {
  description = "Security group ID of the app server (for RDS access)"
  value       = aws_security_group.app-sg.id
}

output "app_instance_id" {
  description = "Instance ID of the app server"
  value       = aws_instance.app.id
}
