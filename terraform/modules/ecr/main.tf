provider "aws" {
  region = "us-east-1"
}

# ====================================================================
# 1. Create ECR Repository - Users Service - Order Service - Products Service
# ====================================================================

resource "aws_ecr_repository" "this" {
  for_each = toset(var.repository_names)

  name                 = "${var.environment}-${each.value}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.environment}-${each.value}-ecr"
    Environment = "${var.environment}"
  }
}
