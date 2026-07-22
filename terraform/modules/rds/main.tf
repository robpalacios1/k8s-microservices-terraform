provider "aws" {
  region = "us-east-1"
}

# ====================================================================
# 1. DB Subnet Group
# ====================================================================

resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnets_ids

  tags = {
    Name        = "${var.environment}-db-subnet-group"
    Environment = "${var.environment}"
  }
}

# ====================================================================
# 2. Security Group for RDS
# ====================================================================

resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL within VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-rds-sg"
    Environment = "${var.environment}"
  }
}

# ====================================================================
# 3. RDS Instance
# ====================================================================

resource "aws_db_instance" "main" {
  identifier     = "${var.environment}-postgres-db"
  engine         = "postgres"
  engine_version = "16.3"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "app_db"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  multi_az            = false

  tags = {
    Name        = "${var.environment}-postgres-db"
    Environment = "${var.environment}"
  }
}