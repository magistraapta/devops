variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "db_subnet_id" {
  description = "Subnet ID for the database"
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID of the app servers (to allow MySQL access)"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true # Marks as sensitive in logs
}
