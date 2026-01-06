terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.aws_regions
}

# Data source to fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "networking" {
  source            = "./modules/networking"
  availability_zone = var.availability_zone
}

module "application" {
  source = "./modules/application"

  ami_id        = coalesce(var.ami_id, data.aws_ami.amazon_linux.id)
  subnet_id     = module.networking.public_subnet_id
  vpc_id        = module.networking.vpc_id
  key_pair_name = var.key_pair_name
}
