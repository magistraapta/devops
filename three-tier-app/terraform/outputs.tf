// ===========================================
// Networking Outputs
// ===========================================
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

// ===========================================
// Compute Outputs
// ===========================================
output "app_public_ip" {
  description = "Public IP of the App server - Access your app here!"
  value       = module.compute.app_public_ip
}

output "app_public_dns" {
  description = "Public DNS of the App server"
  value       = module.compute.app_public_dns
}

output "app_private_ip" {
  description = "Private IP of the application server"
  value       = module.compute.app_private_ip
}

// ===========================================
// Database Outputs
// ===========================================
output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.database.db_endpoint
}

output "db_port" {
  description = "RDS database port"
  value       = module.database.db_port
}

// ===========================================
// Connection Instructions
// ===========================================
output "connection_info" {
  description = "How to connect to your infrastructure"
  value       = <<-EOT
    
    ========================================
    🚀 Three-Tier App Deployment Complete!
    ========================================
    
    📍 Access your app:
       http://${module.compute.app_public_ip}
    
    🔐 SSH to App server:
       ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${module.compute.app_public_ip}
    
    🗄️ Database connection (from App server):
       mysql -h ${module.database.db_endpoint} -u admin -p
    
    EOT
}
