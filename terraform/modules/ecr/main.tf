provider "aws" {
  region = "us-east-1"
}

# ====================================================================
# 1. Create ECR Repository
# ====================================================================

resource "aws_ecr_repository" "users_service" {
  name                 = "dev-users-service"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "dev-users-service-ecr"
    Environment = "dev"
  }
}

# ====================================================================
# 2. Create ECR Repository - Orders Service
# ====================================================================

resource "aws_ecr_repository" "orders_service" {
  name                 = "dev-orders-service"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "dev-orders-service-ecr"
    Environment = "dev"
  }
}

# ====================================================================
# 3. Create ECR Repository - Products Service
# ====================================================================

resource "aws_ecr_repository" "products_service" {
  name                 = "dev-products-service"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "dev-products-service-ecr"
    Environment = "dev"
  }
}