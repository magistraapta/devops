// ===========================================
// DB Subnet Group
// ===========================================
resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-group"
  subnet_ids = [var.db_subnet_id]

  tags = {
    Name = "db-subnet-group"
  }
}

// ===========================================
// RDS MySQL Instance
// ===========================================
resource "aws_db_instance" "db" {
  identifier     = "mydb"
  instance_class = "db.t3.micro"
  engine         = "mysql"
  engine_version = "8.0"

  # Storage
  allocated_storage     = 20
  max_allocated_storage = 100 # Enable autoscaling up to 100GB
  storage_type          = "gp2"

  # Credentials
  username = "admin"
  password = var.db_password

  # Network
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  publicly_accessible    = false

  # Backup & Maintenance
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:04:00-Mon:05:00"

  # Other settings
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true # Set to false in production!

  tags = {
    Name = "mydb"
  }
}

// ===========================================
// Security Group for RDS
// ===========================================
resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL from app servers"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_security_group_id] # Only from app EC2
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}
