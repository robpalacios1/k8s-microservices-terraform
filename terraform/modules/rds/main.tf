provider "aws" {
  region = "us-east-1"
}

# ====================================================================
# 1. DB Subnet Group
# ====================================================================

resource "aws_db_subnet_group" "main" {
  name = "dev-db-subnet-group"

  subnet_ids = [
    "subnet-0063d05c85409b96f",
    "subnet-037b863e5fe3b5852"
  ]

  tags = {
    Name        = "dev-db-subnet-group"
    Environment = "dev"
  }
}

# ====================================================================
# 2. Security Group for RDS
# ====================================================================

resource "aws_security_group" "rds_sg" {
  name        = "dev-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = "vpc-021ab8ce158853394" # Replace with your VPC ID

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
    Name        = "dev-rds-sg"
    Environment = "dev"
  }
}