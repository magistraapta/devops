provider "aws" {
  region = var.aws_region
}

// ===========================================
// Data Source: Ubuntu AMI
// ===========================================
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// ===========================================
// Networking Module
// ===========================================
module "networking" {
  source = "./networking"

  vpc_cidr           = var.vpc_cidr
  availability_zone  = var.availability_zone
  public_subnet_cidr = var.public_subnet_cidr
  db_subnet_cidr     = var.db_subnet_cidr
  project_name       = var.project_name
}

// ===========================================
// Compute Module (Nginx + App Server)
// ===========================================
module "compute" {
  source = "./compute"

  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_id             = module.networking.vpc_id
  public_subnet_id   = module.networking.public_subnet_id
  public_subnet_cidr = module.networking.public_subnet_cidr
  project_name       = var.project_name
}

// ===========================================
// Database Module (RDS MySQL)
// ===========================================
module "database" {
  source = "./database"

  vpc_id                = module.networking.vpc_id
  db_subnet_id          = module.networking.database_subnet_id
  app_security_group_id = module.compute.app_security_group_id
  db_password           = var.db_password
}
