// ===========================================
// AWS Configuration
// ===========================================
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = "ap-southeast-1a"
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "three-tier-app"
}

// ===========================================
// Network Configuration
// ===========================================
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_subnet_cidr" {
  description = "CIDR block for database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

// ===========================================
// Compute Configuration
// ===========================================
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "app-key-pair"
}

// ===========================================
// Database Configuration
// ===========================================
variable "db_password" {
  description = "Password for RDS database"
  type        = string
  default     = "StrongPassword123"
  sensitive   = true
}
