provider "aws" {
    region = "us-east-1"
}

# ====================================================================
# 1. Create ECR Repository
# ====================================================================

resource "aws_ecr_repository" "users_service" {
    name = "dev-users-service"
    image_tag_mutability = "IMMUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }

    tags = {
        Name        = "dev-users-service-ecr"
        Environment = "dev"
    }
}