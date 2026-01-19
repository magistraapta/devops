variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for Nginx"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR for security group rules"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "three-tier-app"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name for EC2"
  type        = string
  default     = ""
}
